import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/change_page_index_event.dart';
import 'package:dsfulfill_cient_app/events/edit_custom_event.dart';
import 'package:dsfulfill_cient_app/events/logined_event.dart';
import 'package:dsfulfill_cient_app/events/new_team_event.dart';
import 'package:dsfulfill_cient_app/events/set_team_event.dart';
import 'package:dsfulfill_cient_app/events/updateAvatar_event.dart';
import 'package:dsfulfill_cient_app/models/client_domain_model.dart';
import 'package:dsfulfill_cient_app/models/custom_client_model.dart';
import 'package:dsfulfill_cient_app/services/me_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:dsfulfill_cient_app/views/components/base_dialog.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MeController extends BaseController {
  final currencyModel = Get.find<AppState>().currencyModel;
  final userInfo = Get.find<AppState>().userInfo.obs;
  final teamInfo = Get.find<AppState>().team.obs;
  final userAvatar = ''.obs;
  final userName = ''.obs;
  final userEmail = ''.obs;
  final token = Get.find<AppState>().token.obs;
  AppState userInfoModel = Get.find<AppState>();
  AppState teamModel = Get.find<AppState>();
  final balance = 0.0.obs;
  @override
  void onInit() {
    super.onInit();

    if (token.value != '') {
      userAvatar.value = Get.find<AppState>().userInfo['avatar'];
      userName.value = Get.find<AppState>().userInfo['name'];
      userEmail.value = Get.find<AppState>().userInfo['email'];
    }
    ApplicationEvent.getInstance()
        .event
        .on<UpdateAvatarEvent>()
        .listen((event) {
      userAvatar.value = Get.find<AppState>().userInfo['avatar'];
    });

    ApplicationEvent.getInstance().event.on<LoginedEvent>().listen((event) {
      userAvatar.value = Get.find<AppState>().userInfo['avatar'];
      userName.value = Get.find<AppState>().userInfo['name'];
      userEmail.value = Get.find<AppState>().userInfo['email'];
      loadData();
    });
    loadData();
  }

  loadData() async {
    getBalance();
  }

  getBalance() async {}

  void onLogout() async {
    var res = await BaseDialog.confirmDialog(Get.context!, '确定要退出登录吗?'.tr);
    if (res != true) return;
    userInfoModel.clear();
    teamModel.clear();
    balance.value = 0.0;
    ApplicationEvent.getInstance()
        .event
        .fire(ChangePageIndexEvent(pageName: 'home'));
  }
}
