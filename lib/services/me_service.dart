import 'package:dsfulfill_admin_app/common/http_client.dart';
import 'package:dsfulfill_admin_app/models/client_domain_model.dart';
import 'package:dsfulfill_admin_app/models/company_model.dart';
import 'package:dsfulfill_admin_app/models/custom_client_model.dart';
import 'package:dsfulfill_admin_app/models/profile_model.dart';

class MeService {
  static const String getCompanyApi = 'company';
  static const String setDefaultTeamApi = 'company/switch';
  static const String getClientDomainApi = 'application/get-client-domain';
  static const String customClientApi = 'application/get-custom-client';
  static const String editCustomClientConfigApi =
      'application/edit-custom-client';
  static const String getProfileApi = 'members/profile';
  static const String systemConfigApi = 'system-config';
  static const String getAppConfigApi = 'mobile-app/get-config';
  static const String setAppConfigApi = 'mobile-app/set-config';

  static Future<Map<String, dynamic>> getSystemConfig() async {
    Map<String, dynamic> result = {'data': null};
    await ApiConfig.instance.get(systemConfigApi).then((response) {
      if (response.ok) {
        result = response.data;
      }
    });
    return result;
  }

  static Future<Map<String, dynamic>> getAppConfig() async {
    Map<String, dynamic> result = {'data': null};
    await ApiConfig.instance.get(getAppConfigApi).then((response) {
      if (response.ok) {
        result = response.data;
      }
    });
    return result;
  }

  static Future<bool> setAppConfig(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .post(setAppConfigApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<ProfileModel?> getProfile() async {
    ProfileModel? result;
    await ApiConfig.instance.get(getProfileApi).then((response) {
      if (response.ok) {
        result = ProfileModel.fromJson(response.data);
      }
    });
    return result;
  }

  static Future<bool> editCustomClientConfig(
      Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .put(editCustomClientConfigApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<Map<String, dynamic>> createCompany(
      Map<String, dynamic> params) async {
    Map<String, dynamic> result = {'ok': false, 'msg': '', 'data': null};
    await ApiConfig.instance.post(getCompanyApi, data: params).then((response) {
      if (response.ok) {
        result = {
          'ok': true,
          'msg': response.msg,
          'data': response.data,
        };
      }
    });
    return result;
  }

  static Future<ClientDomainModel?> getClientDomain() async {
    ClientDomainModel? result;
    await ApiConfig.instance.get(getClientDomainApi).then((response) {
      if (response.ok) {
        result = ClientDomainModel.fromJson(response.data);
      }
    });
    return result;
  }

  static Future<CustomClientModel?> getCustomClient() async {
    CustomClientModel? result;
    await ApiConfig.instance.get(customClientApi).then((response) {
      if (response.ok) {
        result = CustomClientModel.fromJson(response.data);
      }
    });
    return result;
  }

  static Future<bool> setDefaultTeam(id) async {
    bool result = false;
    await ApiConfig.instance.put('$setDefaultTeamApi/$id').then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<List<CompanyModel>> getCompanyList(
      Map<String, dynamic> params) async {
    List<CompanyModel> result = [];
    await ApiConfig.instance
        .get(getCompanyApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(CompanyModel.fromJson(data));
        });
      }
    });
    return result;
  }
}
