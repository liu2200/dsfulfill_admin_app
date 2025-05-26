import 'package:dsfulfill_admin_app/views/workbench/finance/online_recharge/online_recharge_controller.dart';
import 'package:get/get.dart';

class OnlineRechargeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnlineRechargeController());
  }
}
