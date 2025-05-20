import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class SocalLogin {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final FacebookAuth _facebookAuth;
  late final GoogleSignIn _googleAuth;

  SocalLogin() {
    _googleAuth = GoogleSignIn(
      scopes: ['email'],
    );
    _facebookAuth = FacebookAuth.instance;
  }

  /// 生成随机nonce字符串
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// 对字符串进行SHA256哈希
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // facebook 登录
  Future<String?> signInFacebook() async {
    try {
      // 先尝试登出，清理旧状态
      await _facebookAuth.logOut();

      // 生成一个nonce，作为防止重放攻击的安全措施
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);
      debugPrint('nonce: $nonce');
      debugPrint('开始Facebook登录流程...');

      final result = await FacebookAuth.instance.login(
        loginTracking: LoginTracking.limited,
        nonce: nonce,
      );

      // 检查登录状态
      if (result.status == LoginStatus.success) {
        debugPrint('Facebook登录成功');

        // 获取用户信息，这在Limited登录时很重要
        try {
          final userData = await _facebookAuth.getUserData();
          debugPrint('Facebook用户数据: ${userData.toString()}');
        } catch (e) {
          debugPrint('获取用户数据失败: $e');
          // 继续处理，不要中断流程
        }

        // 处理iOS 17+的新认证方式
        if (result.accessToken != null) {
          if (result.accessToken is AccessToken) {
            // 传统方式处理普通的AccessToken (Android和低版本iOS)
            debugPrint('使用传统Token方式登录Firebase');
            final accessToken = result.accessToken as AccessToken;
            OAuthCredential facebookAuthCredential =
                FacebookAuthProvider.credential(accessToken.tokenString);
            UserCredential userCredential = await _firebaseAuth
                .signInWithCredential(facebookAuthCredential);
            debugPrint('Facebook传统登录Firebase成功');
            return userCredential.user?.getIdToken();
          } else if (result.accessToken is LimitedToken) {
            // iOS 17+的新认证方式
            debugPrint('使用iOS 17+新Limited Token方式登录Firebase');
            final limitedToken = result.accessToken as LimitedToken;
            // 创建OAuthCredential
            OAuthCredential credential = OAuthCredential(
              providerId: 'facebook.com',
              signInMethod: 'oauth',
              idToken: limitedToken.tokenString,
              rawNonce: rawNonce,
            );
            UserCredential userCredential =
                await _firebaseAuth.signInWithCredential(credential);
            debugPrint('Facebook新方式登录Firebase成功');
            return userCredential.user?.getIdToken();
          }
        }
      } else if (result.status == LoginStatus.cancelled) {
        debugPrint('用户取消了Facebook登录');
      } else {
        debugPrint('Facebook登录失败: ${result.message}');
      }
    } catch (error) {
      debugPrint('===== Facebook登录异常 =====');
      debugPrint('错误类型: ${error.runtimeType}');
      debugPrint('错误信息: ${error.toString()}');

      if (error is TimeoutException) {
        debugPrint('连接超时: ${error.message}');
        EasyLoading.showError('登录超时，请检查网络连接');
      } else if (error is PlatformException) {
        debugPrint('平台异常代码: ${error.code}');
        debugPrint('平台异常消息: ${error.message}');
        EasyLoading.showError('登录失败: ${error.message}');
      } else if (error is FirebaseAuthException) {
        debugPrint('Firebase认证异常代码: ${error.code}');
        debugPrint('Firebase认证异常消息: ${error.message}');
        EasyLoading.showError('认证失败: ${error.message}');
      } else if (error is SocketException ||
          error.toString().contains('SocketException')) {
        debugPrint('网络连接错误: ${error.toString()}');
        EasyLoading.showError('网络连接错误，请检查网络');
      } else if (error.toString().contains('connection')) {
        debugPrint('可能的连接问题: ${error.toString()}');
        EasyLoading.showError('连接问题，请检查网络');
      } else {
        debugPrint('其他未知异常');
        EasyLoading.showError('登录出错，请稍后重试');
      }

      debugPrint('===== Facebook登录流程失败 =====');
      return null;
    }

    debugPrint('===== Facebook登录流程未完成 =====');
    return null;
  }

  // google 登录
  Future<String?> signInGoogle() async {
    try {
      // 先尝试登出，避免某些状态问题
      await _googleAuth.signOut();

      // 登录步骤
      GoogleSignInAccount? account = await _googleAuth.signIn();

      // 用户取消登录
      if (account == null) {
        debugPrint('用户取消了登录');
        return null;
      }

      // 获取认证信息
      GoogleSignInAuthentication googleAuth = await account.authentication;

      // 检查token是否有效
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        debugPrint('Google登录失败: 无法获取有效token');
        return null;
      }

      // 创建认证凭据
      OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // 使用凭据登录Firebase
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // 返回idToken用于后端验证
      return userCredential.user?.getIdToken();
    } catch (error) {
      debugPrint('Google登录错误: ${error.toString()}');
      if (error is PlatformException) {
        EasyLoading.showError('登录失败: ${error.code}');
      } else if (error is FirebaseAuthException) {
        EasyLoading.showError('Firebase认证失败: ${error.message}');
      } else {
        EasyLoading.showError('登录失败，请稍后重试');
      }
      return null;
    }
  }

  // 测试Facebook登录过程并返回详细信息
  Future<Map<String, dynamic>> testFacebookLogin() async {
    Map<String, dynamic> result = {'success': false, 'data': {}};

    try {
      // 先尝试登出，清理旧状态
      await _facebookAuth.logOut();
      debugPrint('开始测试Facebook登录流程...');

      // 基本登录
      final loginResult = await _facebookAuth.login(
        permissions: ['public_profile', 'email'],
      );

      result['status'] = loginResult.status.toString();
      result['accessToken'] = loginResult.accessToken != null;
      result['tokenType'] = loginResult.accessToken?.runtimeType.toString();

      if (loginResult.accessToken != null) {
        // 尝试获取用户信息
        try {
          final userData = await _facebookAuth.getUserData();
          result['userData'] = userData;
          result['success'] = true;
        } catch (e) {
          result['userDataError'] = e.toString();
        }
      }
    } catch (e) {
      result['error'] = e.toString();
    }

    debugPrint('Facebook登录测试结果: $result');
    return result;
  }
}
