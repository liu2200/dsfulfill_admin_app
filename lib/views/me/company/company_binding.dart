import 'package:get/get.dart';
import 'package:dsfulfill_admin_app/views/me/company/company_controller.dart';

class CompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyController());
  }
}
