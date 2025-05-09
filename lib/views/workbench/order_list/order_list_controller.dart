import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/list_refresh_event.dart';
import 'package:dsfulfill_cient_app/models/country_model.dart';
import 'package:dsfulfill_cient_app/models/customer_model.dart';
import 'package:dsfulfill_cient_app/models/express_lines_model.dart';
import 'package:dsfulfill_cient_app/models/order_model.dart';
import 'package:dsfulfill_cient_app/models/shop_model.dart';
import 'package:dsfulfill_cient_app/models/supplier_model.dart';
import 'package:dsfulfill_cient_app/services/home_service.dart';
import 'package:dsfulfill_cient_app/services/marketing_service.dart';
import 'package:dsfulfill_cient_app/services/workbench_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController keywordController = TextEditingController();
  final TextEditingController productKeywordController =
      TextEditingController(); // 平台sku
  final TextEditingController logisticsKeywordController =
      TextEditingController(); // 物流单号

  final tabIndex = 0.obs;
  late TabController tabController;
  final currencyModel = Get.find<AppState>().currencyModel;

  // 客户下拉框专用：id为RxString，客户列表为RxList
  final RxString customerIdController = ''.obs; // 选中的客户id
  final RxList<CustomerModel> clientList = <CustomerModel>[].obs; // 客户列表

  final RxString shopIdsController = ''.obs;
  final RxList<ShopModel> shopList = <ShopModel>[].obs; // 店铺列表

  final RxString platformController = ''.obs;
  final platformList = [
    {"label": "shopify", "id": "shopify"},
    {"label": "woocommerce", "id": "woocommerce"},
    {"label": "shoplazza", "id": "shoplazza"},
    {"label": "shopline", "id": "shopline"},
    {"label": "magento", "id": "magento"},
    {"label": "zid", "id": "zid"},
  ].obs; // 店铺列表

  final RxString expressController = ''.obs;
  final RxList<ExpressLinesModel> expressLinesList = <ExpressLinesModel>[].obs;

  final RxString trackingStatusController = ''.obs;
  final trajectoryList = [
    {"label": "未查询".tr, "id": "0"},
    {"label": "查询不到".tr, "id": "1"},
    {"label": "包裹揽收".tr, "id": "2"},
    {"label": "运输途中".tr, "id": "3"},
    {"label": "运输过久".tr, "id": "4"},
    {"label": "到达代取".tr, "id": "5"},
    {"label": "派送途中".tr, "id": "6"},
    {"label": "投递失败".tr, "id": "7"},
    {"label": "成功签收".tr, "id": "8"},
    {"label": "可能异常".tr, "id": "9"},
  ].obs; //轨迹

  final RxString countryController = ''.obs;
  final RxList<CountryModel> countryList = <CountryModel>[].obs;

  final RxString timeRangeTypeController = '1'.obs;
  final timeRangeKeywordList = [
    {"label": "创建时间".tr, "id": "1"},
    {"label": "更新时间".tr, "id": "2"},
    {"label": "付款时间".tr, "id": "3"},
    {"label": "交运时间".tr, "id": "4"},
    {"label": "发货时间".tr, "id": "5"},
  ].obs; //轨迹

  final Rx<DateTime?> filterStartDate = Rx<DateTime?>(null);
  final Rx<DateTime?> filterEndDate = Rx<DateTime?>(null);

  // 供应商列表
  final RxList<SupplierModel> supplierList = <SupplierModel>[].obs;
  int pageIndex = 0;
  final switchTabList = [
    "sku_status",
    "logistics_status",
    "stock_status",
    "abnormal_reason",
    "financial_status",
    "other_status",
  ];
  final pageParams = {
    "id": "",
    "order_keyword_type": 2,
    "product_keyword_type": 1,
    "logistics_keyword_type": 1,
    "order_type": 1, //订单类型 1-代发订单 2-备货订单 固定代发订单
    "title": "", //产品名称
    "country": "", //国家
    "begin_date": "", //开始时间
    "end_date": "", //结束时间
    "sku_status": "",
    "platform": "", //平台渠道
    "purchase": "",
    "sort": 1,
    "is_shipping": "", //是否发货
    "staff_id": "", //员工ID
    "select": "",
    "no_waybill_number": "", //无运单号
    "financial_status": "", //财务状态
    "is_disable": "", //禁止处理
    "fulfillment_platform": "", //履单系统
    "logistics": "",
    "abnormal_reason": "", //平台异常原因
    "logistics_status": "",
    "stock_status": "",
    "other_status": "",
  };
  final orderListStatus = [
    {
      'label': '全部'.tr,
      'status': '',
      'show_count': false,
      'count': 0,
      'id': 7,
    },
    {
      'label': '报价中'.tr,
      'status': 1,
      'count': 0,
      'id': 1,
      'show_count': true,
    },
    {
      'label': '已报价'.tr,
      'status': 2,
      'count': 0,
      'id': 2,
      'show_count': true,
    },
    {
      'label': '已付款'.tr,
      'status': 3,
      'count': 0,
      'id': 3,
      'show_count': true,
    },
    {
      'label': '配货中'.tr,
      'status': 4,
      'count': 0,
      'id': 4,
      'show_count': true,
    },
    {
      'label': '已出库'.tr,
      'status': 5,
      'count': 0,
      'id': 5,
      'show_count': true,
    },
    {
      'label': '有异常'.tr,
      'status': 'abnormal',
      'count': 0,
      'id': 6,
      'show_count': true,
    },
  ].obs;

  final orderList = <OrderModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    getOrderCount();
    getCustomList();
    getShopList();
    getExpressList();
    getCountryList();
    tabController = TabController(length: 7, vsync: this);
    ApplicationEvent.getInstance().event.on<ListRefreshEvent>().listen((event) {
      if (event.type == 'refresh') {
        pageIndex = 0;
        getOrderCount();
        loadMoreList();
      }
    });
  }

  @override
  void onClose() {
    reset();
  }

  reset() {
    customerIdController.value = '';
    shopIdsController.value = '';
    expressController.value = '';
    trackingStatusController.value = '';
    countryController.value = '';
    timeRangeTypeController.value = '1';
    platformController.value = '';
    filterStartDate.value = null;
    filterEndDate.value = null;
  }

  switchTab() {
    for (var item in switchTabList) {
      pageParams[item] = "";
    }
  }

  loadList({type}) async {
    pageIndex = 0;
    return await loadMoreList();
  }

  getCountryList() async {
    var result = await WorkbenchService.getCountryList();
    countryList.value = result;
  }

  getExpressList() async {
    var result = await WorkbenchService.getExpressList({
      'page': 1,
      'size': 9999,
    });
    expressLinesList.value = result;
  }

  getShopList() async {
    var result = await WorkbenchService.getShopList({
      'page': 1,
      'size': 1000,
    });
    shopList.value = result;
  }

  getCustomList() async {
    var result = await MarketingService.getCustomList({
      'page': 1,
      'size': 1000,
    });
    clientList.value = result;
  }

  getOrderCount() async {
    Map result = await HomeService.getOrderCount({
      "page": (++pageIndex),
      "order_keyword": keywordController.text,
      "status": orderListStatus[tabIndex.value]['status'],
      "product_keyword": productKeywordController.text,
      "logistics_keyword": logisticsKeywordController.text,
      "customer_id": customerIdController.value,
      "express_line_id": expressController.value,
      "tracking_status": trackingStatusController.value,
      "country": countryController.value,
      "time_range_type": timeRangeTypeController.value,
      "time_range_start": filterStartDate.value?.toIso8601String(),
      "time_range_end": filterEndDate.value?.toIso8601String(),
      ...pageParams,
    });
    // ignore: invalid_use_of_protected_member
    for (var element in orderListStatus.value) {
      final status = element['status'];
      element['count'] = result[status.toString()] ?? result[status] ?? 0;
    }
    orderListStatus.refresh();
  }

  loadMoreList() async {
    Map result = await WorkbenchService.getOrderList({
      "page": (++pageIndex),
      "order_keyword": keywordController.text,
      "status": orderListStatus[tabIndex.value]['status'],
      "product_keyword": productKeywordController.text,
      "logistics_keyword": logisticsKeywordController.text,
      "shop_ids": [shopIdsController.value],
      "customer_id": customerIdController.value,
      "express_line_id": expressController.value,
      "tracking_status": trackingStatusController.value,
      "country": countryController.value,
      "time_range_type": timeRangeTypeController.value,
      "time_range_start": filterStartDate.value?.toIso8601String(),
      "time_range_end": filterEndDate.value?.toIso8601String(),
      ...pageParams,
    });
    return result;
  }
}
