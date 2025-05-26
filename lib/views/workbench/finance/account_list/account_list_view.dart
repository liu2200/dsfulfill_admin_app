import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/utils/base_utils.dart';
import 'package:dsfulfill_admin_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/workbench/finance/account_list/account_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountListView extends GetView<AccountListController> {
  const AccountListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '线下收款账号'.tr,
      hasBack: true,
      backgroundColor: AppStyles.background,
      body: Obx(() {
        if (controller.accountList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.accountList.length,
          itemBuilder: (context, index) {
            final account = controller.accountList[index];
            return _buildAccountCard(account);
          },
        );
      }),
    );
  }

  Widget _buildAccountCard(account) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppStyles.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E5E5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 银行名称标题和Copy All按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText(
                  text: account.name ?? '',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppStyles.textBlack,
                ),
              ),
              TextButton(
                onPressed: () {
                  _copyAccountInfo(account);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppStyles.primary),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: AppText(
                    text: '复制全部'.tr,
                    fontSize: 12.sp,
                    color: AppStyles.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // 银行账户信息
          if (account.paymentSettingConnection != null)
            ...account.paymentSettingConnection!.map((setting) {
              return _buildInfoRow(
                label: setting.name,
                value: setting.content,
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标签
          AppText(
            text: label,
            fontSize: 12.sp,
            color: const Color(0xFF999999),
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 6.h),
          // 值和复制按钮
          Row(
            children: [
              Expanded(
                child: AppText(
                  text: value,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppStyles.textBlack,
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () => BaseUtils.copy(value),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  child: Icon(
                    Icons.copy,
                    size: 18.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _copyAccountInfo(account) {
    StringBuffer accountInfo = StringBuffer();

    accountInfo.writeln(account.name);
    if (account.paymentSettingConnection != null) {
      for (var setting in account.paymentSettingConnection!) {
        accountInfo.writeln('${setting.name} : ${setting.content}');
      }
    }

    BaseUtils.copy(accountInfo.toString().trim());
  }
}
