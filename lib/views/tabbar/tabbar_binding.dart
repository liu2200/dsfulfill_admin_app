import 'package:dsfulfill_cient_app/views/analysis/analysis_controller.dart';
import 'package:dsfulfill_cient_app/views/me/me_controller.dart';
import 'package:dsfulfill_cient_app/views/home/home_controller.dart';
import 'package:dsfulfill_cient_app/views/tabbar/tabbar_controller.dart';
import 'package:dsfulfill_cient_app/views/workbench/workbench_controller.dart';
import 'package:get/get.dart';

class TabbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TabbarController());
    Get.put(HomeController());
    Get.put(WorkbenchController());
    Get.put(AnalysisController());
    Get.put(MeController());
  }
}
