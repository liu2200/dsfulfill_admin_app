import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/services/me_service.dart';
import 'package:dsfulfill_admin_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModifyPasswordController extends BaseController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final isRegister = true.obs;
  final phone = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    var profile = await MeService.getProfile();
    if (profile != null) {
      phoneController.text = profile.phone;
      phone.value = profile.phone;
    }
  }

  validateConfirmPassword() async {
    if (verificationCodeController.text.isEmpty) {
      return showToast('请输入验证码'.tr);
    }
    if (newPasswordController.text.isEmpty) {
      return showToast('请输入新密码'.tr);
    }
    if (confirmPasswordController.text.isEmpty) {
      return showToast('请输入确认密码'.tr);
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      return showToast('两次密码不一致'.tr);
    }
    showLoading();
    var result = await UserService.forgotPassword({
      'phone': phoneController.text,
      'email': '',
      'type': 'phone',
      'verification_code': verificationCodeController.text,
      'password': newPasswordController.text,
      'confirm_password': confirmPasswordController.text,
    });
    if (result) {
      Get.back();
    }
    hideLoading();
  }
}
