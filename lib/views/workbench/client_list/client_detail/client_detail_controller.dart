import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/events/application_event.dart';
import 'package:dsfulfill_admin_app/events/client_list_event.dart';
import 'package:dsfulfill_admin_app/events/list_refresh_event.dart';
import 'package:dsfulfill_admin_app/models/area_code_model.dart';
import 'package:dsfulfill_admin_app/models/custom_group_model.dart';
import 'package:dsfulfill_admin_app/models/customer_model.dart';
import 'package:dsfulfill_admin_app/services/custom_service.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientDetailController extends BaseController {
  final customerDetail = Rxn<CustomerModel>();
  final isAutoPayment = 1.obs;
  final currencyModel = Get.find<AppState>().currencyModel;
  final TextEditingController customNameController =
      TextEditingController(); //用户名
  final TextEditingController customEmailController =
      TextEditingController(); //邮箱
  final TextEditingController customPhoneController =
      TextEditingController(); //手机号
  final TextEditingController commissionRateController =
      TextEditingController(); //佣金比例
  final TextEditingController commissionAmountController =
      TextEditingController(); //佣金金额
  final TextEditingController creditLineController = TextEditingController();
  final RxString staffId = ''.obs;
  // 电话区号
  RxString phoneAreaCodeController = '0086'.obs;
  final RxList<CustomGroupModel> clientGroupList =
      <CustomGroupModel>[].obs; // 客户分组列表
  @override
  void onInit() {
    super.onInit();
    getCustomGroupList();
    if (Get.arguments['id'] != null) {
      getCustomDetail(Get.arguments['id']);
    }
  }

  getCustomDetail(id) async {
    var result = await CustomService.getCustomDetail(id);
    if (result != null) {
      customerDetail.value = result;
      isAutoPayment.value = customerDetail.value?.isAutoPayment ?? 1;
      customNameController.text = customerDetail.value?.customName ?? '';
      customEmailController.text = customerDetail.value?.customEmail ?? '';
      customPhoneController.text = customerDetail.value?.customPhone ?? '';
      staffId.value = customerDetail.value?.groupId.toString() == '0'
          ? ''
          : customerDetail.value?.groupId.toString() ?? '';
      commissionRateController.text =
          customerDetail.value?.commissionRate.toString() ?? '';
      commissionAmountController.text =
          customerDetail.value?.commissionAmount.toString() ?? '';
      phoneAreaCodeController.value =
          customerDetail.value?.phoneAreaCode.toString() ?? '0086';
    }
  }

  updateAutoPayment(Map<String, dynamic> params) async {
    bool result = await CustomService.updateAutoPayment(params);
    if (result) {
      customerDetail.value?.isAutoPayment = params['is_auto_payment'];
      isAutoPayment.value = params['is_auto_payment'];
    }
  }

  String formatTimezone(String timezone) {
    var reg = RegExp(r'^0{1,}');
    return timezone.replaceAll(reg, '');
  }

  // 选择手机区号
  void onTimezone() async {
    var s = await Routers.push(Routers.areaCode);
    if (s != null) {
      AreaCodeModel a = s as AreaCodeModel;
      phoneAreaCodeController.value = a.code;
    }
  }

  getCustomGroupList() async {
    var result = await CustomService.getCustomGroupList({
      'page': 1,
      'size': 1000,
    });
    if (result.isNotEmpty) {
      clientGroupList.value = result;
    }
  }

  updateClientInfo() async {
    if (customNameController.text.isEmpty) {
      return showToast('请输入用户名'.tr);
    }
    if (customPhoneController.text.isEmpty) {
      return showToast('请输入手机号'.tr);
    }
    if (staffId.value.isEmpty) {
      return showToast('请选择分组'.tr);
    }
    if (commissionRateController.text.isEmpty) {
      return showToast('请输入佣金比例'.tr);
    }
    if (commissionAmountController.text.isEmpty) {
      return showToast('请输入佣金金额'.tr);
    }
    Map<String, dynamic> params = {
      'custom_name': customNameController.text,
      'custom_email': customEmailController.text,
      'custom_phone': customPhoneController.text,
      'phone_area_code': phoneAreaCodeController.value,
      'commission_rate': commissionRateController.text,
      'commission_amount': commissionAmountController.text,
      'group_id': staffId.value,
      'default_language': customerDetail.value?.defaultLanguage ?? '',
      'goods_once_price': '',
    };
    bool result =
        await CustomService.updateCustom(customerDetail.value?.id, params);
    if (result) {
      showToast('修改成功'.tr);
      ApplicationEvent.getInstance().event.fire(ClientListEvent());
      Get.back();
      Get.back();
    }
  }

  updateCreditLine() async {
    if (creditLineController.text.isEmpty) {
      return showToast('请输入新额度'.tr);
    }
    Map<String, dynamic> params = {
      'id': customerDetail.value?.id,
      'original_credit_line': customerDetail.value?.creditLine,
      'residual_credit': customerDetail.value?.residualCredit,
      'credit_line': creditLineController.text,
    };
    bool result = await CustomService.updateCreditLine(params);
    if (result) {
      showToast('修改成功'.tr);
      ApplicationEvent.getInstance()
          .event
          .fire(ListRefreshEvent(type: 'refresh'));
      Get.back();
      Get.back();
    }
  }
}
