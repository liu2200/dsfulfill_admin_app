import 'dart:async';

import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/models/area_code_model.dart';
import 'package:dsfulfill_admin_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dsfulfill_admin_app/config/base_controller.dart';

class RegisterController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final RxBool agreeTerms = false.obs;
  // 使用 Rx 包装手机号
  final Rx<String> mobileNumber = ''.obs;
  final Rx<String> emailNumber = ''.obs;
  final TextEditingController mobileNumberController = TextEditingController();

  final canGetCode = true.obs;
  Timer? timer;
  final count = 60.obs;
  final isEmailRegister = true.obs;
  // 电话区号
  RxString areaNumber = '0086'.obs;

  @override
  void onInit() {
    super.onInit();
    // 添加监听器，当输入变化时更新 mobileNumber
    mobileNumberController.addListener(() {
      mobileNumber.value = mobileNumberController.text;
    });
    emailController.addListener(() {
      emailNumber.value = emailController.text;
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    mobileNumberController.dispose();
    codeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    timer?.cancel();
    super.onClose();
  }

  void toggleRegisterType() {
    isEmailRegister.value = !isEmailRegister.value;
    emailController.text = '';
    mobileNumberController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    codeController.text = '';
  }

  // 选择手机区号
  void onTimezone() async {
    var s = await Routers.push(Routers.areaCode);
    if (s != null) {
      AreaCodeModel a = s as AreaCodeModel;
      areaNumber.value = a.code;
    }
  }

  String formatTimezone(String timezone) {
    var reg = RegExp(r'^0{1,}');
    return timezone.replaceAll(reg, '');
  }

  // 获取验证码
  getCode() async {
    if (!canGetCode.value) return;
    if (isEmailRegister.value) {
      if (emailController.text.isEmpty) {
        return showToast('请输入邮箱'.tr);
      }
    }
    showLoading();
    UserService.getSendEmailCode(
      {
        'captchaVerifyParam':
            '{\"sceneId\":\"1n4ghta4\",\"certifyId\":\"wBkmJHiZwN\",\"deviceToken\":\"V0VCI2FiMDM0ZWMwNj',
        'email': emailController.text,
        'type': 'register',
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

  register() async {
    if (isEmailRegister.value) {
      if (emailController.text.isEmpty) {
        return showToast('请输入邮箱'.tr);
      } else if (passwordController.text.isEmpty) {
        return showToast('请输入密码'.tr);
      } else if (confirmPasswordController.text.isEmpty) {
        return showToast('请输入确认密码'.tr);
      } else if (passwordController.text != confirmPasswordController.text) {
        return showToast('密码不一致'.tr);
      }
    } else {
      if (mobileNumberController.text.isEmpty) {
        return showToast('请输入手机号'.tr);
      }
    }
    if (codeController.text.isEmpty) {
      return showToast('请输入验证码'.tr);
    } else if (!agreeTerms.value) {
      return showToast('请同意用户协议'.tr);
    }
    try {
      Map<String, dynamic> map = {
        'confirm_password': confirmPasswordController.text,
        'email': emailController.text,
        'invite_company_code': null,
        'invite_member_code': null,
        'is_agreed': true,
        'password': passwordController.text,
        'phone': mobileNumberController.text,
        'phone_area_code': areaNumber.value,
        'promotion_invite_code': '',
        'type': isEmailRegister.value ? 'email' : 'phone',
        'verification_code': codeController.text,
      };
      var res = await UserService.register(map);
      if (res['ok']) {
        EasyLoading.showSuccess(res['msg']);
        Routers.pop();
      }
    } catch (e) {
      hideLoading();
    }
  }
}
