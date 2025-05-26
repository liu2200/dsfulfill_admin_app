import 'package:dsfulfill_admin_app/views/workbench/order_list/order_detail/order_detall_controller.dart';
import 'package:get/get.dart';

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailController());
  }
}
