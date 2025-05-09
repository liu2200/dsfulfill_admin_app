import 'package:get/get.dart';
import 'recharge_list_controller.dart';

class RechargeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RechargeListController());
  }
}
