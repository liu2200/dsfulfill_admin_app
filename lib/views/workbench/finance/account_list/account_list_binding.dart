import 'package:get/get.dart';

import 'account_list_controller.dart';

class AccountListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountListController());
  }
}
