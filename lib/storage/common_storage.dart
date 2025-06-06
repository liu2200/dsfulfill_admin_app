import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CommonStorage {
  static String tokenKey = "token";
  static String languageKey = "language";
  static String userInfoKey = "userInfo";
  static String teamKey = "team";
  static String guideKey = "guide";
  static String deviceTokenKey = 'device-token';

  static Locale? getLanguage() {
    String? code = GetStorage().read(languageKey);
    if (code != null) {
      return Locale(code.split('_').first, code.split('_').last);
    }
    return null;
  }

  static void setLanguage(String data) {
    GetStorage().write(languageKey, data);
  }

  static String getToken() {
    return GetStorage().read(tokenKey) ?? '';
  }

  static void setToken(String data) {
    GetStorage().write(tokenKey, data);
  }

  static void clearToken() {
    GetStorage().remove(tokenKey);
  }

  static void clearUserInfo() {
    GetStorage().remove(userInfoKey);
  }

  static void clearTeam() {
    GetStorage().remove(teamKey);
  }

  static Map<String, dynamic> getUserInfo() {
    return GetStorage().read(userInfoKey) ?? {};
  }

  static void setUserInfo(Map<String, dynamic> data) {
    GetStorage().write(userInfoKey, data);
  }

  static Map<String, dynamic> getTeam() {
    return GetStorage().read(teamKey) ?? {};
  }

  static void setTeam(Map<String, dynamic> data) {
    GetStorage().write(teamKey, data);
  }

  static void setGuide(bool data) {
    GetStorage().write(guideKey, data);
  }

  static bool getGuide() {
    return GetStorage().read(guideKey) ?? true;
  }

  static void setDeviceToken(String data) {
    GetStorage().write(deviceTokenKey, data);
  }

  static String getDeviceToken() {
    return GetStorage().read(deviceTokenKey) ?? '';
  }
}
