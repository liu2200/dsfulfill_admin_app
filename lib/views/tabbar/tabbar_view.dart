import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/analysis/analysis_view.dart';
import 'package:dsfulfill_cient_app/views/me/me_view.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/home/home_view.dart';
import 'package:dsfulfill_cient_app/views/tabbar/tabbar_controller.dart';
import 'package:dsfulfill_cient_app/views/workbench/workbench_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TabbarView extends GetView<TabbarController> {
  const TabbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeView(),
          WorkbenchView(),
          AnalysisView(),
          MeView(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppStyles.line,
            ),
          ),
          color: Colors.white,
        ),
        child: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: AppStyles.primary,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: AppStyles.grey9,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppStyles.grey9,
              fontSize: 12.sp,
            ),
            currentIndex: controller.currentPage.value,
            onTap: controller.onPageItem,
            items: [
              BottomNavigationBarItem(
                icon: LoadAssetImage(
                  image: 'tab/home_uns',
                  width: 24.w,
                  height: 24.w,
                ),
                activeIcon: LoadAssetImage(
                  image: 'tab/home',
                  width: 24.w,
                  height: 24.w,
                ),
                label: '首页'.tr,
              ),
              BottomNavigationBarItem(
                icon: LoadAssetImage(
                  image: 'tab/workbench_uns',
                  width: 24.w,
                  height: 24.w,
                ),
                activeIcon: LoadAssetImage(
                  image: 'tab/workbench',
                  width: 24.w,
                  height: 24.w,
                ),
                label: '工作台'.tr,
              ),
              BottomNavigationBarItem(
                icon: LoadAssetImage(
                  image: 'tab/analysis_uns',
                  width: 24.w,
                  height: 24.w,
                ),
                activeIcon: LoadAssetImage(
                  image: 'tab/analysis',
                  width: 24.w,
                  height: 24.w,
                ),
                label: '分析'.tr,
              ),
              BottomNavigationBarItem(
                icon: LoadAssetImage(
                  image: 'tab/center_uns',
                  width: 24.w,
                  height: 24.w,
                ),
                activeIcon: LoadAssetImage(
                  image: 'tab/center',
                  width: 24.w,
                  height: 24.w,
                ),
                label: '我的'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
