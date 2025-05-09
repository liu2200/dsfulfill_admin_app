import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/logined_event.dart';
import 'package:dsfulfill_cient_app/events/set_team_event.dart';
import 'package:dsfulfill_cient_app/models/order_statistics_model.dart';
import 'package:dsfulfill_cient_app/services/home_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:get/get.dart';

class AnalysisController extends GetxController {
  final timeFilters = [
    {"label": "今天".tr, "value": "today"},
    {"label": "昨天".tr, "value": "yesterday"},
    {"label": "周".tr, "value": "week"},
    {"label": "月".tr, "value": "month"},
    {"label": "年".tr, "value": "year"},
  ].obs;
  final RxString dateType = 'today'.obs;
  final orderTotalStatistics = Rxn<List<OrderStatisticsModel>>();
  final token = Get.find<AppState>().token.obs;

  @override
  void onInit() {
    super.onInit();
    getOrderTotalStatistics();
    ApplicationEvent.getInstance().event.on<LoginedEvent>().listen((event) {
      token.value = Get.find<AppState>().token;
      // loadData();
    });
    ApplicationEvent.getInstance().event.on<SetTeamEvent>().listen((event) {
      getOrderTotalStatistics();
    });
  }

  getOrderTotalStatistics() async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 6));
    var result = await HomeService.getOrderTotalStatistics({
      'start_date':
          '${sevenDaysAgo.year}-${sevenDaysAgo.month.toString().padLeft(2, '0')}-${sevenDaysAgo.day.toString().padLeft(2, '0')}',
      'end_date':
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
    });
    orderTotalStatistics.value = result;
  }
}
