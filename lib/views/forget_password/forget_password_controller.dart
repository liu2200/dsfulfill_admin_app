import 'dart:async';

import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends BaseController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final RxBool agreeTerms = false.obs;
  final TextEditingController codeController = TextEditingController();
  final Rx<String> accountNumber = ''.obs;
  final isEmailRegister = true.obs;

  final canGetCode = true.obs;
  Timer? timer;
  final count = 60.obs;

  @override
  void onInit() {
    accountController.addListener(() {
      accountNumber.value = accountController.text;
    });
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    codeController.dispose();
    confirmPasswordController.dispose();
    timer?.cancel();
    super.onClose();
  }

  getCode() async {
    if (!canGetCode.value) return;
    if (emailController.text.isEmpty) {
      return showToast('emailIsEmpty'.tr);
    }
    showLoading();
    UserService.getSendSmsCode(
      {
        'email': emailController.text,
        'type': 'forgot_password',
      },
      (data) {
        onCountdown();
        hideLoading();
      },
      (message) {
        hideLoading();
      },
    );
  }

  toggleRegisterType() {
    isEmailRegister.value = !isEmailRegister.value;
    accountController.text = '';
    passwordController.text = '';
    codeController.text = '';
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

  confirmed() async {
    if (isEmailRegister.value) {
      if (accountController.text.isEmpty) {
        return showToast('请输入邮箱'.tr);
      }
    } else {
      if (accountController.text.isEmpty) {
        return showToast('请输入手机号'.tr);
      }
    }
    if (codeController.text.isEmpty) {
      return showToast('请输入验证码'.tr);
    } else if (passwordController.text.isEmpty) {
      return showToast('请输入密码'.tr);
    } else if (confirmPasswordController.text.isEmpty) {
      return showToast('请输入确认密码'.tr);
    } else if (passwordController.text != confirmPasswordController.text) {
      return showToast('密码不一致'.tr);
    }
    showLoading();
    var result = await UserService.forgotPassword(
      {
        'password': passwordController.text,
        'confirm_password': confirmPasswordController.text,
        'verification_code': codeController.text,
        'type': isEmailRegister.value ? 'email' : 'phone',
        'email': isEmailRegister.value ? accountController.text : null,
        'phone': isEmailRegister.value ? null : accountController.text,
      },
    );
    if (result) {
      Routers.pop();
    }
    hideLoading();
  }
}
