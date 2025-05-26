import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/models/balance_record_model.dart';
import 'package:dsfulfill_admin_app/services/finance_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TransactionDetailController extends BaseController {
  final balanceRecordDetail = Rxn<BalanceRecordModel>();
  final currencyModel = Get.find<AppState>().currencyModel;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['id'] != null) {
      getBalanceRecordDetail(Get.arguments['id'].toString());
    }
  }

  copyNo(String serialNo) async {
    await Clipboard.setData(ClipboardData(text: serialNo));
    showToast('复制成功'.tr);
  }

  getBalanceRecordDetail(id) async {
    var result = await FinanceService.getBalanceRecordDetail(id);
    balanceRecordDetail.value = result;
  }
}
