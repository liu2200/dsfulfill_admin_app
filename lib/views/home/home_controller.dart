import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/events/application_event.dart';
import 'package:dsfulfill_admin_app/events/change_page_index_event.dart';
import 'package:dsfulfill_admin_app/events/logined_event.dart';
import 'package:dsfulfill_admin_app/events/set_team_event.dart';
import 'package:dsfulfill_admin_app/models/home_model.dart';
import 'package:dsfulfill_admin_app/services/home_service.dart';
import 'package:dsfulfill_admin_app/services/me_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final currencyModel = Get.find<AppState>().currencyModel;
  final token = Get.find<AppState>().token.obs;
  final team = Get.find<AppState>().team.obs;
  final clientUrl = ''.obs;
  final tabIndex = 0.obs;
  final homeModel = HomeModel(
    orderStatistics: null,
    expressLinesCount: 0,
    goodsCount: 0,
    orderCount: 0,
    rechargeCount: 0,
    transferRechargeCount: 0,
    onlineRechargeCount: 0,
  ).obs;

  final rechargeListStatus = [
    {
      'label': '待审核转账充值',
      'status': 0,
      'count': 0,
      'index': 1,
      'type': 'transfer',
    },
    {
      'label': '待核账在线充值',
      'status': 0,
      'count': 0,
      'index': 1,
      'type': 'online',
    },
  ].obs;
  final orderListStatus = [
    {
      'label': '待报价',
      'status': 0,
      'count': 0,
      'index': 1,
    },
    {
      'label': '待申请运单',
      'status': 3,
      'count': 0,
      'index': 4,
    },
    // {
    //   'label': '待配货',
    //   'status': 4,
    //   'count': 0,
    //   'index': 5,
    // },
    {
      'label': '异常订单',
      'status': 'abnormal',
      'count': 0,
      'index': 7,
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    ApplicationEvent.getInstance().event.on<LoginedEvent>().listen((event) {
      token.value = Get.find<AppState>().token;
      loadData();
    });
    ApplicationEvent.getInstance()
        .event
        .on<ChangePageIndexEvent>()
        .listen((event) {
      if (event.pageName == 'home') {
        homeModel.value = HomeModel(
          orderStatistics: null,
          expressLinesCount: 0,
          goodsCount: 0,
          orderCount: 0,
          rechargeCount: 0,
          transferRechargeCount: 0,
          onlineRechargeCount: 0,
        );
        token.value = Get.find<AppState>().token;
      }
    });
    ApplicationEvent.getInstance().event.on<SetTeamEvent>().listen((event) {
      loadData();
    });

    loadData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAppConfig() async {
    var res = await MeService.getSystemConfig();
    if (res['client_url'] != null) {
      clientUrl.value = res['client_url'];
    }
  }

  getHomeData() async {
    var result = await HomeService.getHomeData();
    homeModel.value = result;
    // ignore: invalid_use_of_protected_member
    rechargeListStatus.value[0]['count'] = result.transferRechargeCount ?? 0;
    // ignore: invalid_use_of_protected_member
    rechargeListStatus.value[1]['count'] = result.onlineRechargeCount ?? 0;
  }

  getOrderCount() async {
    var result = await HomeService.getOrderCount({
      'order_keyword_type': 1,
      'order_type': 1,
      'batch_keyword_type': 1,
      'product_keyword_type': 1,
      'status': 0,
      'page': 1,
      'size': 50,
      'total': 0,
      'sort': 1,
      'time_range_type': 1
    });
    // ignore: invalid_use_of_protected_member
    for (var element in orderListStatus.value) {
      final status = element['status'];
      element['count'] = result[status.toString()] ?? result[status] ?? 0;
    }
    orderListStatus.refresh();
  }

  Future<void> loadData() async {
    await getHomeData();
    await getOrderCount();
    await getAppConfig();
  }
}
