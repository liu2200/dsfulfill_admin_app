import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/utils/base_utils.dart';
import 'package:dsfulfill_admin_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/input/base_input.dart';
import 'package:dsfulfill_admin_app/views/components/select_dropdown.dart';
import 'package:dsfulfill_admin_app/views/workbench/client_list/client_detail/client_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientDetailView extends GetView<ClientDetailController> {
  const ClientDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '客户详情'.tr,
      hasBack: true,
      backgroundColor: AppStyles.background,
      bottomNavigationBar: Container(
        padding:
            EdgeInsets.only(top: 10.h, bottom: 34.h, right: 16.h, left: 16.h),
        decoration: const BoxDecoration(
          color: AppStyles.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: EdgeInsets.all(14.w),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: '修改客户信息'.tr,
                                      fontSize: 16.sp,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                _editField(
                                  '用户名'.tr,
                                  hint: '请输入用户名'.tr,
                                  controller.customNameController,
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    AppText(
                                      text: '* ',
                                      color: Colors.red,
                                      fontSize: 15.sp,
                                    ),
                                    AppText(
                                      text: '电话'.tr,
                                      fontSize: 15.sp,
                                    ),
                                  ],
                                ),
                                inputPhoneView(context),
                                SizedBox(height: 12.h),
                                _editField(
                                    '邮箱'.tr, controller.customEmailController),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    AppText(
                                      text: '* ',
                                      color: Colors.red,
                                      fontSize: 15.sp,
                                    ),
                                    AppText(
                                      text: '请选择分组'.tr,
                                      fontSize: 15.sp,
                                    ),
                                  ],
                                ),
                                Obx(() => SelectDropdown(
                                      hint: '请选择'.tr,
                                      items: controller.clientGroupList,
                                      getId: (e) => e.id.toString(),
                                      getName: (e) => e.groupName,
                                      selectedId: controller.staffId.value,
                                      showClear: false,
                                      onChanged: (id) {
                                        controller.staffId.value = id;
                                      },
                                    )),
                                SizedBox(height: 12.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                        child: _editField('佣金比例'.tr,
                                            controller.commissionRateController,
                                            suffixWidget: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.w, right: 8.w),
                                              child: Text(
                                                '%',
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.black54),
                                              ),
                                            ))),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                        child: _editField(
                                            '',
                                            controller
                                                .commissionAmountController,
                                            suffixWidget: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.w, right: 8.w),
                                              child: Text(
                                                'USD',
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.black54),
                                              ),
                                            ))),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.updateClientInfo();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppStyles.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: AppText(
                                          text: '确认'.tr,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.white,
                  side: const BorderSide(color: AppStyles.textBlack),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: AppText(
                  text: '修改'.tr,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  final model = controller.customerDetail.value;
                  if (model == null) return;
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: EdgeInsets.all(14.w),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: '调整信用额度'.tr,
                                      fontSize: 16.sp,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                AppText(
                                  text: '原信用额度'.tr,
                                  color: Colors.black54,
                                  fontSize: 14.sp,
                                ),
                                SizedBox(height: 8.h),
                                AppText(
                                  text:
                                      '${model.creditLine} ${controller.currencyModel['symbol']}  (${'剩余额度'.tr}：${model.residualCredit})',
                                  fontSize: 12.sp,
                                ),
                                SizedBox(height: 18.h),
                                Row(
                                  children: [
                                    AppText(
                                      text: '* ',
                                      color: Colors.red,
                                      fontSize: 15.sp,
                                    ),
                                    AppText(
                                      text: '调整后额度'.tr,
                                      fontSize: 15.sp,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: BaseInput(
                                        controller:
                                            controller.creditLineController,
                                        hintText: '请输入新额度'.tr,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, right: 8.w),
                                      child: AppText(
                                        text:
                                            '${controller.currencyModel['symbol']}',
                                        fontSize: 15.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.updateCreditLine();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppStyles.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: AppText(
                                          text: '确认'.tr,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primary,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: AppText(
                  text: '调整信用额度'.tr,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        final model = controller.customerDetail.value;
        if (model == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 客户信息
                    _sectionCard('客户信息'.tr, [
                      // _infoRow('客户ID'.tr, model.id.toString()),
                      _infoRow('客户名称'.tr, model.customName, isCopiable: true),
                      _infoRow('邮箱'.tr, model.customEmail, isCopiable: true),
                      _infoRow('注册时间'.tr, model.createdAt),
                      _infoRow('最后登录时间'.tr, model.lastLoginTime),
                      _infoRow('员工'.tr, model.staffName),
                    ]),
                    SizedBox(height: 16.h),
                    // 支付信息
                    _sectionCard('账户信息'.tr, [
                      _infoRow('余额'.tr, model.balance.toString()),
                      _infoRow('消费总额'.tr, model.consumeAmount.toString()),
                      _infoRow('信用额度'.tr, model.creditLine.toString()),
                      _infoRow('剩余额度'.tr, model.residualCredit),
                    ]),
                    SizedBox(height: 16.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15.w),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText(
                              text: '自动支付'.tr,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                          Obx(() => Switch(
                                value: controller.isAutoPayment.value == 1,
                                activeColor: AppStyles.primary,
                                onChanged: (value) {
                                  controller.updateAutoPayment(
                                    {
                                      'ids': [model.id],
                                      'is_auto_payment': value ? 1 : 0,
                                    },
                                  );
                                },
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // 区块卡片
  Widget _sectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp)),
          SizedBox(height: 8.h),
          ...children,
        ],
      ),
    );
  }

  inputPhoneView(BuildContext context) {
    var inputAccountView = Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xFFEAEAEB)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.fromLTRB(7.w, 0, 0, 2.h),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              controller.onTimezone();
            },
            child: Row(
              children: <Widget>[
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: AppStyles.line)),
                  child: Obx(
                    () => AppText(
                      text:
                          '+${controller.formatTimezone(controller.phoneAreaCodeController.value)}',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                10.horizontalSpace,
                SizedBox(
                  height: 12.h,
                  child: const VerticalDivider(
                    thickness: 2,
                    color: Color(0xFFEEEEEE),
                  ),
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: BaseInput(
              controller: controller.customPhoneController,
              hintText: '请输入手机号'.tr,
            ),
          ),
        ],
      ),
    );
    return inputAccountView;
  }

  // 信息行
  Widget _infoRow(String label, String value, {bool isCopiable = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 150, child: AppText(text: label, color: Colors.black54)),
          Expanded(
            child: AppText(
              text: value,
              color: Colors.black87,
              textAlign: TextAlign.right,
            ),
          ),
          if (isCopiable && value.isNotEmpty) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => BaseUtils.copy(value),
              child: Icon(
                Icons.copy,
                size: 16.sp,
                color: AppStyles.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // 编辑弹窗输入框
  Widget _editField(String label, TextEditingController controller,
      {String? prefix, Widget? suffixWidget, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Row(
            children: [
              Text('* ', style: TextStyle(color: Colors.red, fontSize: 14.sp)),
              Text(label, style: TextStyle(fontSize: 14.sp)),
            ],
          ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Expanded(
              child: BaseInput(
                controller: controller,
                hintText: hint,
                prefix: prefix != null
                    ? Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text(prefix, style: TextStyle(fontSize: 15.sp)),
                      )
                    : null,
              ),
            ),
            if (suffixWidget != null) ...[
              suffixWidget,
            ]
          ],
        ),
      ],
    );
  }
}
