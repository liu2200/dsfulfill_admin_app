import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/new_team_event.dart';
import 'package:dsfulfill_cient_app/events/set_team_event.dart';
import 'package:dsfulfill_cient_app/models/company_model.dart';
import 'package:dsfulfill_cient_app/services/me_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:get/get.dart';

class CompanyController extends BaseController {
  final RxList<CompanyModel> companyList = <CompanyModel>[].obs;
  final RxInt selectedCompanyId = RxInt(-1);
  final RxBool isLoading = false.obs;
  final appState = Get.find<AppState>();

  @override
  void onInit() {
    super.onInit();
    getCompanyList();
    ApplicationEvent.getInstance().event.on<NewTeamEvent>().listen((event) {
      getCompanyList();
    });
  }

  Future<void> getCompanyList() async {
    isLoading.value = true;
    var result = await MeService.getCompanyList({
      'size': 999,
    });
    isLoading.value = false;
    if (result.isNotEmpty) {
      companyList.value = result;
      // 默认选中第一个公司
      if (companyList.isNotEmpty && selectedCompanyId.value == -1) {
        selectedCompanyId.value = appState.team['company_id'];
      }
    }
  }

  // 切换选中的团队
  Future<void> selectCompany(CompanyModel item) async {
    var result = await MeService.setDefaultTeam(item.id);
    if (result) {
      selectedCompanyId.value = item.id;
      // 直接修改AppState中的userInfo
      appState.team['company_id'] = item.id;
      appState.team['team_name'] = item.teamName;
      appState.team['team_code'] = item.teamCode;
      appState.saveTeam({
        'company_id': item.id,
        'team_name': item.teamName,
        'team_code': item.teamCode,
      });
      ApplicationEvent.getInstance().event.fire(SetTeamEvent());
    }
  }

  // 创建新团队逻辑（实际实现会调用API）
  void createNewCompany() {
    Routers.push(Routers.newTeam);
  }
}
