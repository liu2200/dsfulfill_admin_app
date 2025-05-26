import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/events/application_event.dart';
import 'package:dsfulfill_admin_app/events/logined_event.dart';
import 'package:dsfulfill_admin_app/services/user_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:dsfulfill_admin_app/storage/common_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class EmailVerifyController extends BaseController {
  final TextEditingController codeController = TextEditingController();
  final Rx<String> email = ''.obs;
  final Rx<int> count = 60.obs;
  final Rx<bool> canGetCode = true.obs;
  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments['email'];
    if (email.value.isNotEmpty) {
      onCountdown();
    }
  }

  void onClose() {
    codeController.dispose();
    timer?.cancel();
    timer = null;
    count.value = 60;
    canGetCode.value = true;
    super.onClose();
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

  nextStep() async {
    if (codeController.text.isEmpty) {
      showToast('请输入验证码'.tr);
      return;
    }
    var params = {
      'verification_code': codeController.text,
      'email': email.value,
      'phone': '',
      'type': 'email',
      'password': '',
      'confirm_password': '',
      'promotion_invite_code': ''
    };
    var res = await UserService.register(params);
    if (res['data'] != null) {
      onLoginSuccess(res['data']);
    }
  }

  onLoginSuccess(Map<String, dynamic> data) {
    //更新状态管理器
    AppState userInfo = Get.find<AppState>();
    userInfo.saveToken('${data['token_type']} ${data['access_token']}');
    ApplicationEvent.getInstance().event.fire(LoginedEvent());
    if (data['company_id'] == 0) {
      Routers.push(Routers.newTeam,
          {'type': 'login', 'isguide': CommonStorage.getGuide()});
    } else {
      if (CommonStorage.getGuide()) {
        Routers.push(Routers.home);
      } else {
        Routers.pop();
        Routers.pop();
        Routers.pop();
      }
    }
    CommonStorage.setGuide(false);
  }

  void getCode() async {
    var params = {
      'captchaVerifyParam': 'dsfulfill',
      'email': email.value,
      'type': 'register',
    };
    await UserService.getSendEmailCode(params, (msg) {
      showToast(msg);
      onCountdown();
    }, (error) {});
  }
}
