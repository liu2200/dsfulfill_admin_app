import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/input/base_input.dart';
import 'package:dsfulfill_admin_app/views/me/new_team/new_team_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewTeamView extends GetView<NewTeamController> {
  const NewTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '创建团队'.tr,
      hasBack: controller.type.value == 'login' ? false : true,
      backgroundColor: AppStyles.background,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppStyles.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  // 标题
                  AppText(
                    text: '创建您的团队'.tr,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
                  // 描述
                  AppText(
                    text: '团队名称'.tr,
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                  SizedBox(height: 16.h),
                  BaseInput(
                    controller: controller.teamNameController,
                    hintText: '请输入团队名称'.tr,
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppStyles.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        controller.createCompany();
                      },
                      child: AppText(
                        text: '提交'.tr,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
