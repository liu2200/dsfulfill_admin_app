import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/workbench/workbench_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkbenchView extends GetView<WorkbenchController> {
  const WorkbenchView({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '工作台'.tr,
      hasBack: false,
      backgroundColor: AppStyles.background,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
        children: [
          _buildSectionTitle('产品'.tr),
          _buildMenuItem('产品管理'.tr, 'product_manage', 'product'),
          _buildMenuItem('产品采集'.tr, 'product_collect', 'collect'),
          _buildSectionTitle('订单'.tr),
          _buildMenuItem('代发订单'.tr, 'order', 'orderList'),
          _buildSectionTitle('财务'.tr),
          _buildMenuItem('转账充值'.tr, 'transfer', 'rechargeList'),
          _buildMenuItem('在线充值'.tr, 'online_charge', 'onlineRecharge'),
          _buildMenuItem('交易流水'.tr, 'transaction', 'transactionList'),
          _buildSectionTitle('客户'.tr),
          _buildMenuItem('客户管理'.tr, 'customer_manage', 'clientList'),
          // _buildMenuItem('客户店铺'.tr, 'customer_shop', 'product'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: AppStyles.textBlack,
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, String iconPath, String route) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppStyles.line),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () => {Routers.push(route)},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              LoadAssetImage(
                image: 'workbench/$iconPath',
                width: 30.w,
                height: 30.w,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: AppText(
                  text: title,
                  fontSize: 15.sp,
                  color: Colors.black87,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.w, color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}
