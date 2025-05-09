import 'package:dsfulfill_cient_app/models/balance_record_model.dart';
import 'package:dsfulfill_cient_app/services/finance_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:get/get.dart';

class TransactionDetailController extends GetxController {
  final balanceRecordDetail = Rxn<BalanceRecordModel>();
  final currencyModel = Get.find<AppState>().currencyModel;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['id'] != null) {
      getBalanceRecordDetail(Get.arguments['id'].toString());
    }
  }

  getBalanceRecordDetail(id) async {
    var result = await FinanceService.getBalanceRecordDetail(id);
    balanceRecordDetail.value = result;
  }
}
