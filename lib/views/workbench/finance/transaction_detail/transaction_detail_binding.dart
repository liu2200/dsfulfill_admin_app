import 'package:dsfulfill_admin_app/views/workbench/finance/transaction_detail/transaction_detail_controller.dart';
import 'package:get/get.dart';

class TransactionDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionDetailController());
  }
}
