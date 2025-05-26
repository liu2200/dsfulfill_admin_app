import 'package:dsfulfill_admin_app/views/workbench/finance/recharge_detail/recharge_detail_controller.dart';
import 'package:get/get.dart';

class RechargeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RechargeDetailController());
  }
}
