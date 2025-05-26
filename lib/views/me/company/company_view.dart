import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/me/company/company_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyView extends GetView<CompanyController> {
  const CompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '选择团队'.tr,
      hasBack: true,
      backgroundColor: AppStyles.background,
      body: Container(
        decoration: const BoxDecoration(
          color: AppStyles.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  // 标题
                  AppText(
                    text: '选择团队'.tr,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
                  // 描述
                  AppText(
                    text: '你已加入以下团队'.tr,
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
            // 团队列表
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.companyList.isEmpty) {
                  Center(
                    child: AppText(
                      text: '暂无团队'.tr,
                      fontSize: 14.sp,
                      color: Colors.black54,
                    ),
                  );
                }

                return GetBuilder<CompanyController>(
                  builder: (ctrl) => ListView.builder(
                    itemCount: controller.companyList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.companyList.length) {
                        return Column(
                          children: [
                            Container(
                              height: 20.h,
                              color: AppStyles.background,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 14.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9.r),
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 4.h,
                                ),
                                leading: Container(
                                  width: 32.w,
                                  height: 32.w,
                                  decoration: const BoxDecoration(
                                    color: AppStyles.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18.w,
                                    ),
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: '创建新团队'.tr,
                                      fontSize: 15.sp,
                                    ),
                                    AppText(
                                      text: '创建属于你的团队'.tr,
                                      fontSize: 12.sp,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                                onTap: () => controller.createNewCompany(),
                              ),
                            ),
                          ],
                        );
                      }

                      final company = controller.companyList[index];

                      // 使用ValueListenableBuilder监听选中状态变化
                      return Obx(() {
                        final isSelected =
                            controller.selectedCompanyId.value == company.id;

                        return Container(
                          margin: EdgeInsets.only(
                            bottom: 16.h,
                            left: 16.w,
                            right: 14.w,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppStyles.primary
                                : AppStyles.background,
                            borderRadius: BorderRadius.circular(8.r),
                            border: isSelected
                                ? null
                                : Border.all(color: Colors.grey[200]!),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 2.h,
                            ),
                            leading: Container(
                              width: 43.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: AppStyles.white,
                                borderRadius: BorderRadius.circular(9.r),
                              ),
                              child: Center(
                                child: Text(
                                  company.teamName[0],
                                  style: TextStyle(
                                    color: AppStyles.textBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            title: AppText(
                              text: company.teamName,
                              fontSize: 15.sp,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            onTap: () async {
                              await controller.selectCompany(company);
                            },
                          ),
                        );
                      });
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
