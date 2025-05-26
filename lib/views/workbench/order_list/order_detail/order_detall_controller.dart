import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/events/application_event.dart';
import 'package:dsfulfill_admin_app/events/list_refresh_event.dart';
import 'package:dsfulfill_admin_app/models/order_model.dart';
import 'package:dsfulfill_admin_app/services/order_service.dart';
import 'package:dsfulfill_admin_app/services/workbench_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
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
  final packages = [].obs;
  final expressLine = {}.obs;
  final quotedNumber = 0.obs;
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
      succeed(context);
      Get.back();
      Get.back();
    }
  }

  orderCancelAndRefund(context) async {
    var result = await WorkbenchService.orderCancelAndRefund({
      "ids": [orderId.value]
    });
    if (result) {
      succeed(context);
      Get.back();
      Get.back();
    }
  }

  ignoreAbnormal(context) async {
    var result = await WorkbenchService.ignoreAbnormal({
      "ids": [orderId.value]
    });
    if (result) {
      succeed(context);
      Get.back();
      Get.back();
    }
  }

  //申请运单号
  expressCompanies(context) async {
    var result = await OrderService.expressCompanies({
      "order_ids": [orderId.value]
    });
    if (result) {
      showToast('申请运单号成功'.tr);
      succeed(context);
    }
  }

  //移入配货中
  removePrint(context) async {
    var result = await OrderService.removePrint({
      "ids": [orderId.value]
    });
    if (result) {
      showToast('操作成功'.tr);
      succeed(context);
    }
  }

  //平台交运
  platformExpress(context) async {
    // 添加确认对话框
    Get.dialog(
      AlertDialog(
        title: Text('平台交运'.tr),
        content: Text('平台交运只支持推送存在物流单号的订单，确定吗？'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('取消'.tr),
          ),
          TextButton(
            onPressed: () async {
              Get.back(); // 关闭对话框
              // 执行原有操作
              var result = await OrderService.syncPlatformFulfillment({
                "ids": [orderId.value]
              });
              if (result) {
                showToast('平台交运成功'.tr);
                succeed(context);
              }
            },
            child: Text('确认'.tr),
          ),
        ],
      ),
    );
  }

  succeed(context) {
    ApplicationEvent.getInstance()
        .event
        .fire(ListRefreshEvent(type: 'refresh'));
    Navigator.of(context).pop();
  }

  getOrderDetail(String id) async {
    var result = await WorkbenchService.getOrderDetails(id);
    packages.value = result!['packages'];
    if (result['express_line'] != '') {
      expressLine.value = result['express_line'];
    }
    if (result['line_items'] != null) {
      result['line_items'].forEach((element) {
        if (element['mapping'] != null) {
          quotedNumber.value += 1;
        }
      });
    }
    print(quotedNumber.value);

    orderDetail.value = OrderModel.fromJson(result);
  }
}
