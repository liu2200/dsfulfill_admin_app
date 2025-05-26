import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/models/customer_model.dart';
import 'package:dsfulfill_admin_app/services/finance_service.dart';
import 'package:dsfulfill_admin_app/services/marketing_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OnlineRechargeController extends BaseController {
  final TextEditingController keywordController = TextEditingController();
  final RxString customerIdController = ''.obs; // 选中的客户id
  final RxString checkStatus = ''.obs;
  int pageIndex = 0;
  final currencyModel = Get.find<AppState>().currencyModel;
  final RxList<CustomerModel> clientList = <CustomerModel>[].obs; // 客户列表
  final Rx<DateTime?> filterStartDate = Rx<DateTime?>(null);
  final Rx<DateTime?> filterEndDate = Rx<DateTime?>(null);
  final RxInt activeFiltersCount = 0.obs;
  final operation = [
    {"label": "未核账", "id": "0"},
    {"label": "已核账", "id": "1"},
  ].obs; //轨迹

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments.containsKey('status')) {
      checkStatus.value = arguments['status'];
    }
    getCustomList();
  }

  loadList({type}) async {
    pageIndex = 0;
    return await loadMoreList();
  }

  loadMoreList() async {
    Map<String, dynamic> dic = {
      "page": (++pageIndex),
      "serial_no": keywordController.text,
      "end_date": filterEndDate.value,
      "begin_date": filterStartDate.value,
      "customer_id": customerIdController.value,
      "check_status": checkStatus.value,
    };
    Map result = await FinanceService.getOnlineRechargeList(dic);
    return result;
  }

  getCustomList() async {
    var result = await MarketingService.getCustomList({
      'page': 1,
      'size': 1000,
    });
    clientList.value = result;
  }

  copyTradeNo(String tradeNo) async {
    await Clipboard.setData(ClipboardData(text: tradeNo));
    showToast('复制成功'.tr);
  }

  reset() {
    customerIdController.value = '';
    checkStatus.value = '';
    filterStartDate.value = null;
    filterEndDate.value = null;
    keywordController.text = '';
    activeFiltersCount.value = 0;
  }

  // 更新活跃筛选条件计数
  updateActiveFiltersCount() {
    int count = 0;
    // 检查各个筛选条件是否有值
    if (customerIdController.value.isNotEmpty) count++;
    if (filterStartDate.value != null || filterEndDate.value != null) count++;
    // 检查其他状态筛选
    if (checkStatus.value.isNotEmpty) count++;
    activeFiltersCount.value = count;
  }
}
