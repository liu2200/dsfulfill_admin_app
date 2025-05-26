import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/events/application_event.dart';
import 'package:dsfulfill_admin_app/events/list_refresh_event.dart';
import 'package:dsfulfill_admin_app/models/recharge_model.dart';
import 'package:dsfulfill_admin_app/services/finance_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RechargeDetailController extends BaseController {
  final rechargeDetail = Rxn<RechargeModel>();
  final currencyModel = Get.find<AppState>().currencyModel;
  final TextEditingController confirmRemark = TextEditingController();
  final TextEditingController confirmAmount = TextEditingController();
  final imageList = <String>[].obs;
  final auditStatus = 1.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['id'] != null) {
      getRechargeDetail(Get.arguments['id'].toString());
    }
  }

  @override
  void onClose() {
    confirmRemark.dispose();
    confirmAmount.dispose();
    imageList.clear();
    super.onClose();
  }

  getRechargeDetail(id) async {
    var result = await FinanceService.getRechargeDetail(id);
    rechargeDetail.value = result;
  }

  copySerialNo(String serialNo) async {
    await Clipboard.setData(ClipboardData(text: serialNo));
    showToast('复制成功'.tr);
  }

  confirm() async {
    if (confirmAmount.text.isEmpty) {
      return showToast('请输入金额'.tr);
    }
    var params = {
      'audit_status': auditStatus.value,
      'confirm_amount': confirmAmount.text,
      'confirm_remark': confirmRemark.text,
      'confirm_images': imageList,
    };
    var result =
        await FinanceService.rechargeAudit(rechargeDetail.value?.id, params);
    if (result) {
      ApplicationEvent.getInstance()
          .event
          .fire(ListRefreshEvent(type: 'refresh'));
      Get.back();
      Get.back();
    }
  }
}
