import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/list_refresh_event.dart';
import 'package:dsfulfill_cient_app/models/order_model.dart';
import 'package:dsfulfill_cient_app/services/workbench_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OrderDetailController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final orderDetail = Rxn<OrderModel>();
  final currencyModel = Get.find<AppState>().currencyModel;
  late TabController tabController;
  final tabIndex = 0.obs;
  final abnormalStatus = 0.obs;
  final abnormal = Rxn<List<AbnormalModel>>();
  final RxString test = 'test'.obs; // 选中的客户id
  final RxString orderId = ''.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
    if (Get.arguments != null && Get.arguments['id'] != null) {
      getOrderDetail(Get.arguments['id'].toString());
      orderId.value = Get.arguments['id'].toString();
      abnormalStatus.value = Get.arguments['abnormalStatus'];
      abnormal.value = Get.arguments['abnormal'];
    }
    ApplicationEvent.getInstance().event.on<ListRefreshEvent>().listen((event) {
      if (event.type == 'refresh') {
        getOrderDetail(Get.arguments['id'].toString());
      }
    });
  }

  moveToQuote(context) async {
    var result = await WorkbenchService.platformAbnormalMoveToQuote({
      "ids": [orderId.value]
    });
    if (result) {
      showToast('移入报价中成功'.tr);
      ApplicationEvent.getInstance()
          .event
          .fire(ListRefreshEvent(type: 'refresh'));
      Navigator.of(context).pop();
      Get.back();
      Get.back();
    }
  }

  getExpress(context) async {
    var result = await WorkbenchService.expressCompanies({
      "order_ids": [orderId.value]
    });
    if (result) {
      showToast('申请运单号成功'.tr);
      ApplicationEvent.getInstance()
          .event
          .fire(ListRefreshEvent(type: 'refresh'));
      Navigator.of(context).pop();
      Get.back();
    }
  }

  orderCancel(context) async {
    var result = await WorkbenchService.orderCancel({
      "ids": [orderId.value]
    });
    if (result) {
      showToast('取消订单成功'.tr);
      ApplicationEvent.getInstance()
          .event
          .fire(ListRefreshEvent(type: 'refresh'));
      Navigator.of(context).pop();
      Get.back();
      Get.back();
    }
  }

  orderCancelAndRefund(context) async {
    var result = await WorkbenchService.orderCancelAndRefund({
      "ids": [orderId.value]
    });
    if (result) {
      showToast('操作成功'.tr);
      ApplicationEvent.getInstance()
          .event
          .fire(ListRefreshEvent(type: 'refresh'));
      Navigator.of(context).pop();
      Get.back();
      Get.back();
    }
  }

  ignoreAbnormal(context) async {
    var result = await WorkbenchService.ignoreAbnormal({
      "ids": [orderId.value]
    });
    if (result) {
      showToast('操作成功'.tr);
      ApplicationEvent.getInstance()
          .event
          .fire(ListRefreshEvent(type: 'refresh'));
      Navigator.of(context).pop();
      Get.back();
      Get.back();
    }
  }

  getOrderDetail(String id) async {
    var result = await WorkbenchService.getOrderDetails(id);
    orderDetail.value = OrderModel.fromJson(result!);
  }
}
