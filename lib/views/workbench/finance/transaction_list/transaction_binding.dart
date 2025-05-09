import 'package:dsfulfill_cient_app/views/workbench/finance/transaction_list/transaction_controller.dart';
import 'package:get/get.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionController());
  }
}
