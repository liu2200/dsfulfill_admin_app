import 'package:dsfulfill_admin_app/views/workbench/order_list/order_quotation/order_quotation_controller.dart';
import 'package:get/get.dart';

class OrderQuotationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderQuotationController());
  }
}
