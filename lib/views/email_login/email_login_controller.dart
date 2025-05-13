import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailLoginController extends BaseController {
  final TextEditingController emailController = TextEditingController();

  void nextStep() async {
    if (emailController.text.isEmpty) {
      showToast('请输入邮箱'.tr);
      return;
    }
    var params = {
      'captchaVerifyParam': 'dsfulfill',
      'email': emailController.text,
      'type': 'register',
    };
    await UserService.getSendEmailCode(params, (msg) {
      showToast(msg);
      Routers.push(Routers.emailVerify, {
        'email': emailController.text,
      });
    }, (error) {
      // showToast(error);
    });
  }
}
