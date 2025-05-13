import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/change_page_index_event.dart';
import 'package:dsfulfill_cient_app/events/new_team_event.dart';
import 'package:dsfulfill_cient_app/events/set_team_event.dart';
import 'package:dsfulfill_cient_app/services/me_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTeamController extends BaseController {
  final TextEditingController teamNameController = TextEditingController();
  final RxString type = ''.obs;
  final appState = Get.find<AppState>();
  final RxBool isGuide = false.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      type.value = 'login'; //如果是登录
      isGuide.value = Get.arguments['isguide'];
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
    if (result['ok']) {
      if (type.value == 'login') {
        var res = await MeService.setDefaultTeam(result['data']['id']);
        if (res) {
          appState.team['company_id'] = result['data']['id'];
          appState.team['team_name'] = result['data']['team_name'];
          appState.team['team_code'] = result['data']['team_code'];
          appState.saveTeam({
            'company_id': result['data']['id'],
            'team_name': result['data']['team_name'],
            'team_code': result['data']['team_code'],
          });
          if (isGuide.value) {
            Routers.push(Routers.home);
          } else {
            Routers.pop();
            Routers.pop();
            Routers.pop();
            Routers.pop();
          }
        }
        // 直接修改AppState中的userInfo
      } else {
        Routers.push(Routers.setBrand, {
          'type': 'new',
        });
      }
      ApplicationEvent.getInstance().event.fire(NewTeamEvent());
    }
  }
}
