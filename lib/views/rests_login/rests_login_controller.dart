import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestLoginController extends BaseController {
  // 处理Apple登录
  void handleAppleLogin() {
    // TODO: 实现Apple登录逻辑
    showToast('Apple登录功能即将上线');
  }

  // 处理Facebook登录
  void handleFacebookLogin() {
    // TODO: 实现Facebook登录逻辑
    showToast('Facebook登录功能即将上线');
  }

  // 处理Google登录
  void handleGoogleLogin() {
    // TODO: 实现Google登录逻辑
    showToast('Google登录功能即将上线');
  }

  // 导航到邮箱登录页面
  void navigateToEmailLogin() {
    Routers.push(Routers.emailLogin);
  }

  // 显示提示信息
  @override
  void showToast(String message, {Duration? duration}) {
    super.showToast(message, duration: duration);
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
