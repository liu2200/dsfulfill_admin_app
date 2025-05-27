import 'package:dsfulfill_admin_app/models/payments_model.dart';
import 'package:dsfulfill_admin_app/services/finance_service.dart';
import 'package:get/get.dart';

class AccountListController extends GetxController {
  final RxList<PaymentsModel> accountList = <PaymentsModel>[].obs; // 客户列表
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getPaymentList();
  }

  getPaymentList() async {
    var result = await FinanceService.getPaymentList();
    accountList.value = result;
    isLoading.value = false;
  }
}
