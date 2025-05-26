import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/events/application_event.dart';
import 'package:dsfulfill_admin_app/events/logined_event.dart';
import 'package:dsfulfill_admin_app/models/token_model.dart';
import 'package:dsfulfill_admin_app/services/me_service.dart';
import 'package:dsfulfill_admin_app/services/user_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:dsfulfill_admin_app/storage/common_storage.dart';
import 'package:dsfulfill_admin_app/views/firebase/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RestLoginController extends BaseController {
  final SocalLogin _auth = SocalLogin();

  final appVersion = ''.obs;
  final isShow = false.obs;

  void onInit() async {
    super.onInit();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
    getSystemConfig();
  }

  // 处理Apple登录
  void handleAppleLogin() {
    // TODO: 实现Apple登录逻辑
    showToast('Apple登录功能即将上线');
  }

  getSystemConfig() async {
    var res = await MeService.getAppConfig();
    if (res['version'] == appVersion.value) {
      isShow.value = true;
    }
  }

  // 处理Facebook登录
  void handleFacebookLogin() async {
    try {
      showLoading();
      String? idToken = await _auth.signInFacebook();
      hideLoading();

      if (idToken != null) {
        var res = await UserService.loginFirebase({
          'id_token': idToken,
          'source': 'facebook',
        });

        if (res != null && res['token'] != null) {
          onLoginSuccess(res['token']);
        } else {
          showToast('登录失败');
        }
      }
    } catch (e) {
      hideLoading();
      debugPrint('Facebook登录错误: $e');
      showToast('登录出错，请稍后重试');
    }
  }

  // 处理Google登录
  handleGoogleLogin() async {
    showLoading();
    String? idToken = await _auth.signInGoogle();
    hideLoading();
    if (idToken != null) {
      var res = await UserService.loginFirebase({
        'id_token': idToken,
        'source': 'google',
      });
      if (res != null) {
        onLoginSuccess(res['token']);
      } else {
        showToast('登录失败'.tr);
      }
    }
  }

  onLoginSuccess(TokenModel tokenModel) {
    //更新状态管理器
    AppState userInfo = Get.find<AppState>();
    userInfo.saveToken('${tokenModel.tokenType} ${tokenModel.accessToken}');
    ApplicationEvent.getInstance().event.fire(LoginedEvent());
    if (tokenModel.companyId == 0) {
      Routers.push(Routers.newTeam,
          {'type': 'google', 'isguide': CommonStorage.getGuide()});
    } else {
      if (CommonStorage.getGuide()) {
        CommonStorage.setGuide(false);
        Routers.push(Routers.home);
      } else {
        Routers.pop();
      }
    }
  }

  // 导航到密码登录页面
  void navigateToPasswordLogin() async {
    Routers.push(Routers.login);
    // final result = await FlutterWebAuth2.authenticate(
    //   url:
    //       'https://erp.dsfulfill.com/appLogin?redirect_uri=dsfulfill://auth&language=${CommonStorage.getLanguage()?.countryCode == 'CN' ? 'zh_CN' : 'en_US'}',
    //   callbackUrlScheme: 'dsfulfill',
    // );
    // print(result);
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
