import 'package:dsfulfill_admin_app/config/base_controller.dart';
import 'package:dsfulfill_admin_app/services/me_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetThemeController extends BaseController {
  final List<Map<String, dynamic>> themeImages = [
    {
      'id': 0,
      'image': 'center/theme1',
      'appColor': const Color(0xFF279A32),
      'webColor': "#279A32",
      'dsSidebarActiveColor': "#eefff0",
      'dsTailwindBgGradientFrom': "#4C37F6",
      'dsTailwindBgGradientTo': "#dae96a"
    },
    {
      'id': 1,
      'image': 'center/theme2',
      'appColor': const Color(0xFF4C37F6),
      'webColor': "#4C37F6",
      'dsSidebarActiveColor': "#DDD7FE",
      'dsTailwindBgGradientFrom': "#4C37F6",
      'dsTailwindBgGradientTo': "#FC5084"
    },
    {
      'id': 2,
      'image': 'center/theme3',
      'appColor': const Color(0xFF157CF6),
      'webColor': "#157CF6",
      'dsSidebarActiveColor': "#E9F9FD",
      'dsTailwindBgGradientFrom': "#157CF6",
      'dsTailwindBgGradientTo': "#ADE4FD"
    },
    {
      'id': 3,
      'image': 'center/theme4',
      'appColor': const Color(0xFFE30102),
      'webColor': "#E30102",
      'dsSidebarActiveColor': "#FFE5E6",
      'dsTailwindBgGradientFrom': "#E30102",
      'dsTailwindBgGradientTo': "#FAC400"
    },
    {
      'id': 4,
      'image': 'center/theme5',
      'appColor': const Color(0xFFFF7716),
      'webColor': "#FF7716",
      'dsSidebarActiveColor': "#FFEED0",
      'dsTailwindBgGradientFrom': "#FFEED0",
      'dsTailwindBgGradientTo': "#FFD44C"
    },
  ];

  // 当前选中的主题色索引
  final selectedThemeIndex = 0.obs;

  // 存储键
  final String themeKey = 'app_theme_color';
  final domain = ''.obs;
  final image = 'center/theme1'.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentTheme();
    getClientDomain();
  }

  getClientDomain() async {
    var res = await MeService.getClientDomain();
    if (res != null) {
      domain.value = res.domain;
    }
  }

  // 获取当前主题
  getCurrentTheme() async {
    final customClient = await MeService.getCustomClient();
    if (customClient?.color != null) {
      var id = customClient?.color?['id'];
      var theme = themeImages.firstWhere((element) => element['id'] == id);
      selectedThemeIndex.value = theme['id'];
      image.value = theme['image'];
    }
  }

  // 选择主题
  selectTheme(int index) async {
    if (index >= 0 && index < themeImages.length) {
      // selectedThemeIndex.value = index;
      var theme = themeImages[index];
      var result = await MeService.editCustomClientConfig({
        'color': {
          'id': theme['id'],
          'defaultColor': theme['webColor'],
          'dsSidebarActiveColor': theme['dsSidebarActiveColor'],
          'dsTailwindBgGradientFrom': theme['dsTailwindBgGradientFrom'],
          'dsTailwindBgGradientTo': theme['dsTailwindBgGradientTo'],
        },
      });
      if (result) {
        getCurrentTheme();
      }
    }
  }
}
