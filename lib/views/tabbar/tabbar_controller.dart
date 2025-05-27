import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/events/application_event.dart';
import 'package:dsfulfill_admin_app/events/change_page_index_event.dart';
import 'package:dsfulfill_admin_app/events/un_authenticate_event.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:dsfulfill_admin_app/views/firebase/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabbarController extends BaseController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Notifications.initialized(Get.context!);
    ApplicationEvent.getInstance()
        .event
        .on<ChangePageIndexEvent>()
        .listen((event) {
      currentPage.value = event.pageName == 'home' ? 0 : 1;

      pageController.jumpToPage(currentPage.value);
    });
    ApplicationEvent.getInstance()
        .event
        .on<UnAuthenticateEvent>()
        .listen((event) {
      // showToast('loginCredentialsAreInvalid'.tr);
      pushToLogin();
    });
  }

  pushToLogin() async {
    var token = Get.find<AppState>().token;
    if (token != '') {
      Get.find<AppState>().clear();
    }
    onPageItem(0);
  }

  onPageItem(int index) {
    pageController.jumpToPage(index);
    currentPage.value = index;
  }
}
