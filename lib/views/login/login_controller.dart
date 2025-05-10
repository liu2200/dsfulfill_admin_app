import 'dart:async';

import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/logined_event.dart';
import 'package:dsfulfill_cient_app/models/token_model.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:dsfulfill_cient_app/storage/common_storage.dart';
import 'package:flutter/material.dart';
import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/services/user_service.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final isEmailRegister = true.obs;
  final Rx<String> mobileNumber = ''.obs;
  final canGetCode = true.obs;
  Timer? timer;
  final count = 60.obs;

  @override
  void onInit() {
    accountController.addListener(() {
      mobileNumber.value = accountController.text;
    });
    super.onInit();
  }

  @override
  void onClose() {
    accountController.dispose();
    passwordController.dispose();
    codeController.dispose();
    super.onClose();
  }

  void toggleRegisterType() {
    isEmailRegister.value = !isEmailRegister.value;
    accountController.text = '';
    passwordController.text = '';
    codeController.text = '';
  }

  login() async {
    if (isEmailRegister.value) {
      if (accountController.text.isEmpty) {
        return showToast('请输入手机号/邮箱'.tr);
      }
      if (passwordController.text.isEmpty) {
        return showToast('请输入密码'.tr);
      }
    } else {
      if (accountController.text.isEmpty) {
        return showToast('请输入手机号'.tr);
      }
      if (codeController.text.isEmpty) {
        return showToast('请输入验证码'.tr);
      }
    }

    try {
      TokenModel? tokenModel;
      tokenModel = await UserService.login({
        'account': accountController.text,
        'password': passwordController.text,
        'invite_company_code': null,
        'invite_member_code': null,
        'phone_verification_code': codeController.text,
        'type': isEmailRegister.value ? 'password' : 'sms',
      });
      if (tokenModel != null) {
        onLoginSuccess(tokenModel);
      }
    } catch (e) {
      showToast(e.toString());
    }
  }

  // 倒计时
  onCountdown() {
    canGetCode.value = false;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      count.value--;
      if (count.value == 0) {
        timer.cancel();
        canGetCode.value = true;
        count.value = 60;
      }
    });
  }

  onLoginSuccess(TokenModel tokenModel) {
    //更新状态管理器
    AppState userInfo = Get.find<AppState>();
    userInfo.saveToken('${tokenModel.tokenType} ${tokenModel.accessToken}');
    ApplicationEvent.getInstance().event.fire(LoginedEvent());
    if (tokenModel.companyId == 0) {
      Routers.push(Routers.newTeam, {'type': 'login'});
    } else {
      if (CommonStorage.getGuide()) {
        CommonStorage.setGuide(false);
        Routers.push(Routers.home);
      } else {
        Routers.pop();
      }
    }
  }
}
