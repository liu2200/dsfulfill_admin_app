import 'package:dsfulfill_cient_app/common/http_response.dart';
import 'package:dsfulfill_cient_app/models/token_model.dart';
import 'package:dsfulfill_cient_app/common/http_client.dart';
import 'package:dsfulfill_cient_app/services/base_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:dsfulfill_cient_app/storage/common_storage.dart';
import 'package:dsfulfill_cient_app/exceptions/login_error_exception.dart';
import 'package:dsfulfill_cient_app/models/area_code_model.dart';
import 'package:get/get.dart';

class UserService {
  // 登录
  static const String loginApi = 'login';
  // 注册
  static const String registerApi = 'register';
  // 获取手机区号列表
  static const String getPhoneAreaCodeListApi = 'phone-area-code-list';

  // 获取验证码
  static const String getSendSmsCodeApi = 'send-sms-code';

  // 获取邮箱验证码
  static const String getSenEmailCodeApi = 'send-email-verification-code';

  // 获取用户信息
  static const String getUserInfoApi = 'home/custom-info';

  // 更新用户信息
  static const String updateUserInfoApi = 'home/update-custom';

  // 更新密码
  static const String updatePasswordApi = 'home/update-password';

  // 忘记密码
  static const String forgotPasswordApi = 'forgot-password';

  // google、facebook 第三方登录
  static const String loginWithFirebase = 'oauth/authenticate';

  static Future<bool> forgotPassword(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .post(UserService.forgotPasswordApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  // 获取手机区号列表
  static Future<List<AreaCodeModel>> getPhoneAreaCodeList() async {
    List<AreaCodeModel> result = [];
    await ApiConfig.instance
        .get(UserService.getPhoneAreaCodeListApi)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(AreaCodeModel.fromJson(data));
        });
      }
    });
    return result;
  }

  // 更新密码
  static Future<bool> updatePassword(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .post(UserService.updatePasswordApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  // 更新用户信息
  static Future<bool> updateUserInfo(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .post(UserService.updateUserInfoApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  //注册获取邮箱验证码
  static Future<bool> getSendEmailCode(
      Map<String, dynamic> params, OnSuccess onSuccess, OnFail onFail) async {
    bool result = false;
    await ApiConfig.instance
        .post(getSenEmailCodeApi, data: params)
        .then((response) {
      if (response.ok) {
        onSuccess(response.msg);
        result = true;
      }
      // response.
      return onFail(response.error!.message);
    }).catchError((error) {
      return onFail(error.toString());
    });
    return result;
  }

  static Future<bool> getSendSmsCode(
      Map<String, dynamic> params, OnSuccess onSuccess, OnFail onFail) async {
    bool result = false;
    await ApiConfig.instance
        .post(getSendSmsCodeApi, data: params)
        .then((response) {
      if (response.ok) {
        onSuccess(response.msg);
        result = true;
      }
      // response.
      return onFail(response.error!.message);
    }).catchError((error) {
      return onFail(error.toString());
    });
    return result;
  }

  // 注册
  static Future<Map> register(Map<String, dynamic> params) async {
    Map res = {'ok': false, 'msg': '', 'data': null};
    await ApiConfig.instance
        .post(UserService.registerApi, data: params)
        .then((response) {
      res = {
        'ok': response.ok,
        'data': response.data,
        'msg': response.msg ?? response.error?.message ?? ''
      };
      _loginResult(response);
    });

    return res;
  }

  // google、facebook 第三方登录
  static Future<Map?> loginFirebase(Map<String, dynamic> params) async {
    Map? result;
    TokenModel? token;
    await ApiConfig.instance
        .post(loginWithFirebase, data: params)
        .then((response) {
      if (response.ok) {
        if (response.data['key'] != null) {
          result = {'key': response.data['key']};
        } else {
          token = _loginResult(response);
          result = {'token': token};
        }
      }
    });

    return result;
  }

  // 账号密码登录
  static Future<TokenModel?> login(Map<String, dynamic> params) async {
    TokenModel? token;
    await ApiConfig.instance
        .post(UserService.loginApi, data: params)
        .then((response) {
      token = _loginResult(response);
    });
    return token;
  }

  // 登录的处理
  static TokenModel _loginResult(HttpResponse response) {
    if (response.ok) {
      var responseList = response.data;
      TokenModel tokenModel = TokenModel.fromJson(responseList);
      var token = '${tokenModel.tokenType} ${tokenModel.accessToken}';
      //存入storage 方便下次启动读取
      CommonStorage.setToken(token);
      Get.find<AppState>().saveUserInfo({
        'name': tokenModel.name,
        'email': tokenModel.email,
        'avatar': tokenModel.avatar ?? '',
      });
      Get.find<AppState>().saveTeam({
        'team_name': tokenModel.teamName,
        'team_code': tokenModel.teamCode,
        'company_id': tokenModel.companyId,
      });

      return tokenModel;
    } else {
      throw LoginErrorException(response.error!.message);
    }
  }
}
