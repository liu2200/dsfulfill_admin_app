import 'package:get/get.dart';
import 'package:dsfulfill_cient_app/storage/common_storage.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

class AppState {
  final token = ''.obs;
  final currencyModel = {
    'symbol': "\$",
    'code': 'USD',
  };
  final userInfo = <String, dynamic>{
    'name': '',
    'email': '',
    'avatar': '',
  }.obs;

  final team = <String, dynamic>{
    'team_name': '',
    'team_code': '',
    'company_id': 0,
  }.obs;

  final networkDisconnect = false.obs;

  final guide = true.obs; //是否第一次进入

  AppState() {
    token.value = CommonStorage.getToken();
    userInfo.value = CommonStorage.getUserInfo();
    team.value = CommonStorage.getTeam();
    guide.value = CommonStorage.getGuide();
  }

  judgeNetWork() async {
    // 判断网络状态
    // var connectivity = Connectivity();
    // networkDisconnect.value =
    //     (await connectivity.checkConnectivity()) == ConnectivityResult.none;

    // onRefreshData();
    // connectivity.onConnectivityChanged.listen((result) {
    //   if (result != ConnectivityResult.none && networkDisconnect.value) {
    //     onRefreshData();
    //   }
    //   networkDisconnect.value = result == ConnectivityResult.none;
    // });
  }

  onRefreshData() {}

  saveUserInfo(Map<String, dynamic> info) {
    userInfo.value = info;
    CommonStorage.setUserInfo(info);
  }

  saveTeam(Map<String, dynamic> info) {
    team.value = info;
    CommonStorage.setTeam(info);
  }

  saveInfo(String t) {
    token.value = t;
    CommonStorage.setToken(t);
  }

  saveToken(String t) {
    token.value = t;
    CommonStorage.setToken(t);
  }

  saveGuide(bool data) {
    guide.value = data;
    CommonStorage.setGuide(data);
  }

  getGuide() {
    guide.value = CommonStorage.getGuide();
  }

  clear() {
    token.value = '';
    userInfo.value = {};
    team.value = {};
    CommonStorage.clearToken();
    CommonStorage.clearUserInfo();
    CommonStorage.clearTeam();
  }
}
