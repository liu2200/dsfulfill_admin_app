import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  // 引导页数据
  final List<Map<String, String>> guidePages = [
    {
      'title': 'DSFulfill',
      'subtitle': '专为 Dropshipping 履约服务商，重新设计Dropshipping agent 系统',
      'image': 'home/guide_page1',
      'background': 'home/guide_back',
    },
    {
      'title': 'DSFulfill 是什么',
      'subtitle':
          'DSFulfill 为 Dropshipping agent 提供一站式软件管理服务，一套系统从履约、报价、仓储、物流、帐单都能轻松解决',
      'image': 'home/guide_page2',
    },
    {
      'title': '自动生成客户端',
      'subtitle':
          '自动为您生成个性化域名的客户端，Dropshipper通过客户端可以进行自助绑定店铺、同步网店订单、铺货到众多网店平台、发起寻源代采、物流轨迹查询、查询帐单、切换多语言模式等操作',
      'image': 'home/guide_page3',
    },
    {
      'title': '专业的管理端',
      'subtitle': '0 门槛使用、专为Dropshipping agent而生',
      'image': 'home/guide_page4',
    },
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < guidePages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // 最后一页，跳转到登录页
      Routers.pop();
      Get.offAllNamed(Routers.login);
      // Routers.push(Routers.login);
    }
  }

  void skipGuide() {
    // 跳过引导页，直接进入登录页
    Routers.pop();
    Get.offAllNamed(Routers.login);
    // Routers.push(Routers.login);
  }
}
