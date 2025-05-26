import 'package:dsfulfill_admin_app/views/me/new_team/new_team_controller.dart';
import 'package:get/get.dart';

class NewTeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewTeamController());
  }
}
