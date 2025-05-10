import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/analysis/analysis_controller.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/no_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisView extends GetView<AnalysisController> {
  const AnalysisView({super.key});
  @override
  Widget build(BuildContext context) {
    // 统一未登录判断
    return Obx(() {
      if (controller.token.value == '') {
        return BaseScafflod(
          title: '数据分析'.tr,
          hasBack: false,
          backgroundColor: AppStyles.background,
          body: NoLogin(),
        );
      }
      return BaseScafflod(
        title: '数据分析'.tr,
        hasBack: false,
        backgroundColor: AppStyles.background,
        body: RefreshIndicator(
          onRefresh: () async {
            controller.loadData();
          },
          child: ListView(
            children: [
              // 头部筛选按钮
              // Obx(() {
              //   return Container(
              //     decoration: const BoxDecoration(color: AppStyles.white),
              //     padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children:
              //           List.generate(controller.timeFilters.length, (index) {
              //         final selected = controller.dateType.value ==
              //             controller.timeFilters[index]['value'];
              //         return Padding(
              //           padding: EdgeInsets.only(
              //               left: index == 0 ? 16.w : 8.w, right: 5.w),
              //           child: GestureDetector(
              //             onTap: () => controller.dateType.value =
              //                 controller.timeFilters[index]['value']!,
              //             child: Container(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 16.h, vertical: 6.h),
              //               decoration: BoxDecoration(
              //                 color: selected
              //                     ? AppStyles.primary
              //                     : const Color(0xFFF5F5F5),
              //                 borderRadius: BorderRadius.circular(9),
              //               ),
              //               child: Text(
              //                 controller.timeFilters[index]['label'] ?? '',
              //                 style: TextStyle(
              //                   color: selected ? Colors.white : Colors.black87,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       }),
              //     ),
              //   );
              // }),
              Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: '出库订单'.tr,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 14.h),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppStyles.line),
                      ),
                      child: Obx(() {
                        if (controller.orderTotalStatistics.value == null ||
                            controller.orderTotalStatistics.value!.isEmpty) {
                          return Container(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(
                                    color: AppStyles.primary,
                                  ),
                                  SizedBox(height: 12.h),
                                  AppText(
                                    text: "loading".tr,
                                    fontSize: 14.sp,
                                    color: AppStyles.textGrey,
                                  )
                                ],
                              ));
                        }
                        try {
                          final data = controller.orderTotalStatistics.value!;

                          if (data.isEmpty) {
                            return const Center(
                                child: Text("No data available"));
                          }

                          final maxValue = data
                              .map((e) => e.num)
                              .fold<double>(0, (a, b) => a > b ? a : b);
                          final maxY = maxValue > 0 ? maxValue * 1.2 : 10.0;

                          return LineChart(
                            LineChartData(
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40.w,
                                    getTitlesWidget: (value, meta) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: AppText(
                                          text: value.toInt().toString(),
                                          fontSize: 10.sp,
                                          color: AppStyles.textGrey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40.h,
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      if (index % 3 == 0 ||
                                          index == data.length - 1) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.h, right: 35.h),
                                          child: AppText(
                                            text: data[index].date,
                                            fontSize: 10.sp,
                                            color: AppStyles.textGrey,
                                          ),
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: maxY / 5,
                                getDrawingHorizontalLine: (value) {
                                  return const FlLine(
                                    color: AppStyles.line,
                                    strokeWidth: 0.8,
                                    dashArray: [5, 3],
                                  );
                                },
                              ),
                              minX: 0,
                              maxX: (data.length - 1).toDouble(),
                              minY: 0,
                              maxY: maxY,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                    data.length,
                                    (index) => FlSpot(
                                      index.toDouble(),
                                      data[index].num.toDouble(),
                                    ),
                                  ),
                                  isCurved: true,
                                  dotData: FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (spot, percent, barData, index) {
                                      return FlDotCirclePainter(
                                        radius: 4,
                                        color: AppStyles.primary,
                                        strokeWidth: 2,
                                        strokeColor: Colors.white,
                                      );
                                    },
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: AppStyles.primary.withOpacity(0.2),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppStyles.primary.withOpacity(0.4),
                                        AppStyles.primary.withOpacity(0.1),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  color: AppStyles.primary,
                                  barWidth: 3,
                                  curveSmoothness: 0.35,
                                ),
                              ],
                            ),
                          );
                        } catch (e) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline,
                                    color: Colors.red, size: 40.sp),
                                SizedBox(height: 12.h),
                                AppText(
                                  text: "Error loading chart",
                                  fontSize: 14.sp,
                                  color: AppStyles.textRed,
                                ),
                                SizedBox(height: 4.h),
                                AppText(
                                  text:
                                      "${e.toString().substring(0, e.toString().length > 50 ? 50 : e.toString().length)}...",
                                  fontSize: 12.sp,
                                  color: AppStyles.textGrey,
                                )
                              ],
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: '订单收入'.tr,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 14.h),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppStyles.line),
                      ),
                      child: Obx(() {
                        if (controller.orderRevenueStatistics.value == null ||
                            controller.orderRevenueStatistics.value!.isEmpty) {
                          return Container(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(
                                    color: AppStyles.primary,
                                  ),
                                  SizedBox(height: 12.h),
                                  AppText(
                                    text: "loading".tr,
                                    fontSize: 14.sp,
                                    color: AppStyles.textGrey,
                                  )
                                ],
                              ));
                        }
                        try {
                          final data = controller.orderRevenueStatistics.value!;

                          if (data.isEmpty) {
                            return const Center(
                                child: Text("No data available"));
                          }

                          final maxValue = data
                              .map((e) => e.num)
                              .fold<double>(0, (a, b) => a > b ? a : b);
                          final maxY = maxValue > 0 ? maxValue * 1.2 : 10.0;

                          return LineChart(
                            LineChartData(
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40.w,
                                    getTitlesWidget: (value, meta) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: AppText(
                                          text: value.toInt().toString(),
                                          fontSize: 10.sp,
                                          color: AppStyles.textGrey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40.h,
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      if (index % 3 == 0 ||
                                          index == data.length - 1) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.h, right: 35.h),
                                          child: AppText(
                                            text: data[index].date,
                                            fontSize: 10.sp,
                                            color: AppStyles.textGrey,
                                          ),
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: maxY / 5,
                                getDrawingHorizontalLine: (value) {
                                  return const FlLine(
                                    color: AppStyles.line,
                                    strokeWidth: 0.8,
                                    dashArray: [5, 3],
                                  );
                                },
                              ),
                              minX: 0,
                              maxX: (data.length - 1).toDouble(),
                              minY: 0,
                              maxY: maxY,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                    data.length,
                                    (index) => FlSpot(
                                      index.toDouble(),
                                      data[index].num.toDouble(),
                                    ),
                                  ),
                                  isCurved: true,
                                  dotData: FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (spot, percent, barData, index) {
                                      return FlDotCirclePainter(
                                        radius: 4,
                                        color: AppStyles.primary,
                                        strokeWidth: 2,
                                        strokeColor: Colors.white,
                                      );
                                    },
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: AppStyles.primary.withOpacity(0.2),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppStyles.primary.withOpacity(0.4),
                                        AppStyles.primary.withOpacity(0.1),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  color: AppStyles.primary,
                                  barWidth: 3,
                                  curveSmoothness: 0.35,
                                ),
                              ],
                            ),
                          );
                        } catch (e) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline,
                                    color: Colors.red, size: 40.sp),
                                SizedBox(height: 12.h),
                                AppText(
                                  text: "Error loading chart",
                                  fontSize: 14.sp,
                                  color: AppStyles.textRed,
                                ),
                                SizedBox(height: 4.h),
                                AppText(
                                  text:
                                      "${e.toString().substring(0, e.toString().length > 50 ? 50 : e.toString().length)}...",
                                  fontSize: 12.sp,
                                  color: AppStyles.textGrey,
                                )
                              ],
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: '客户充值'.tr,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 14.h),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppStyles.line),
                      ),
                      child: Obx(() {
                        if (controller.customerRechargeStatistics.value ==
                                null ||
                            controller
                                .customerRechargeStatistics.value!.isEmpty) {
                          return Container(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(
                                    color: AppStyles.primary,
                                  ),
                                  SizedBox(height: 12.h),
                                  AppText(
                                    text: "loading".tr,
                                    fontSize: 14.sp,
                                    color: AppStyles.textGrey,
                                  )
                                ],
                              ));
                        }
                        try {
                          final data =
                              controller.customerRechargeStatistics.value!;

                          if (data.isEmpty) {
                            return const Center(
                                child: Text("No data available"));
                          }

                          final maxValue = data
                              .map((e) => e.num)
                              .fold<double>(0, (a, b) => a > b ? a : b);
                          final maxY = maxValue > 0 ? maxValue * 1.2 : 10.0;

                          return LineChart(
                            LineChartData(
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40.w,
                                    getTitlesWidget: (value, meta) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: AppText(
                                          text: value.toInt().toString(),
                                          fontSize: 10.sp,
                                          color: AppStyles.textGrey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40.h,
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      if (index % 3 == 0 ||
                                          index == data.length - 1) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.h, right: 35.h),
                                          child: AppText(
                                            text: data[index].date,
                                            fontSize: 10.sp,
                                            color: AppStyles.textGrey,
                                          ),
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: maxY / 5,
                                getDrawingHorizontalLine: (value) {
                                  return const FlLine(
                                    color: AppStyles.line,
                                    strokeWidth: 0.8,
                                    dashArray: [5, 3],
                                  );
                                },
                              ),
                              minX: 0,
                              maxX: (data.length - 1).toDouble(),
                              minY: 0,
                              maxY: maxY,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                    data.length,
                                    (index) => FlSpot(
                                      index.toDouble(),
                                      data[index].num.toDouble(),
                                    ),
                                  ),
                                  isCurved: true,
                                  dotData: FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (spot, percent, barData, index) {
                                      return FlDotCirclePainter(
                                        radius: 4,
                                        color: AppStyles.primary,
                                        strokeWidth: 2,
                                        strokeColor: Colors.white,
                                      );
                                    },
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: AppStyles.primary.withOpacity(0.2),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppStyles.primary.withOpacity(0.4),
                                        AppStyles.primary.withOpacity(0.1),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  color: AppStyles.primary,
                                  barWidth: 3,
                                  curveSmoothness: 0.35,
                                ),
                              ],
                            ),
                          );
                        } catch (e) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline,
                                    color: Colors.red, size: 40.sp),
                                SizedBox(height: 12.h),
                                AppText(
                                  text: "Error loading chart",
                                  fontSize: 14.sp,
                                  color: AppStyles.textRed,
                                ),
                                SizedBox(height: 4.h),
                                AppText(
                                  text:
                                      "${e.toString().substring(0, e.toString().length > 50 ? 50 : e.toString().length)}...",
                                  fontSize: 12.sp,
                                  color: AppStyles.textGrey,
                                )
                              ],
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
