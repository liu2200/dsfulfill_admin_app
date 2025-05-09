import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/area_code/area_code_controller.dart';
import 'package:dsfulfill_cient_app/views/components/input/base_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AreaCodeView extends GetView<AreaCodeController> {
  const AreaCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: AppText(
          text: '选择区号'.tr,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppStyles.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            color: Colors.white,
            child: Container(
              height: 36.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: BaseInput(
                controller: controller.searchController,
                hintText: '搜索国家或区号'.tr,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 8.w,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.filteredList.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppText(
                          text: '没有匹配的国家'.tr,
                          color: AppStyles.textGrey,
                        )
                      ],
                    ))
                  : ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.filteredList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.filteredList[index];
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xFFEAEAEB),
                              ),
                            ),
                          ),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.w),
                            title: Row(
                              children: [
                                Expanded(
                                  child: AppText(
                                    text: item.name,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                AppText(
                                  text: item.code2 ?? '+${item.code}',
                                  fontSize: 14.sp,
                                  color: AppStyles.textGrey,
                                ),
                              ],
                            ),
                            onTap: () => Get.back(result: item),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
