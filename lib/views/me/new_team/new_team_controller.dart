import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/new_team_event.dart';
import 'package:dsfulfill_cient_app/services/me_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTeamController extends BaseController {
  final TextEditingController teamNameController = TextEditingController();
  final RxString type = ''.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      print('login');
      type.value = 'login'; //如果是登录
    }
  }

  createCompany() async {
    if (teamNameController.text.isEmpty) {
      showToast('请输入团队名称'.tr);
      return;
    }
    var result = await MeService.createCompany({
      "team_name": teamNameController.text,
      "brand_name": "",
      "invoice_info": ""
    });
    if (result) {
      if (type.value == 'login') {
        Routers.pop();
        Routers.push(Routers.setBrand, {
          'type': 'login',
        });
      } else {
        Routers.push(Routers.setBrand, {
          'type': 'new',
        });
      }
      ApplicationEvent.getInstance().event.fire(NewTeamEvent());
    }
  }
}
