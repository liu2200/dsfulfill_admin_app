import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/transaction_detail/transaction_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransactionDetailView extends GetView<TransactionDetailController> {
  const TransactionDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '交易详情'.tr,
      hasBack: true,
      backgroundColor: AppStyles.background,
      body: Obx(() {
        final model = controller.balanceRecordDetail.value;
        if (model == null) {
          return const Center();
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 客户信息
                    _sectionCard('客户信息'.tr, [
                      _infoRow('客户ID'.tr, model.custom?.id.toString() ?? ''),
                      _infoRow('客户名称'.tr, model.custom?.customName ?? ''),
                      _infoRow('流水号'.tr, model.serialNo),
                      _infoRow('提交时间'.tr, model.createdAt),
                    ]),
                    SizedBox(height: 16.h),
                    // 支付信息
                    _sectionCard('支付信息'.tr, [
                      _infoRow('支付方式'.tr, model.sourceTypeName),
                      _infoRow(
                          '${'支付金额'.tr} ${controller.currencyModel['code']}',
                          model.amount.toString()),
                      _infoRow('关联单号'.tr, model.orderSn),
                      _infoRow('外部交易号'.tr, model.serialNo),
                      _infoRow('备注'.tr, model.remark),
                      _infoRow('创建时间'.tr, model.createdAt),
                    ]),
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

  // 信息行
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 120, child: AppText(text: label, color: Colors.black54)),
          Expanded(
            child: AppText(
              text: value,
              color: Colors.black87,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
