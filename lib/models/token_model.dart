/*
  登录TOKEN
 */
class TokenModel {
  late String accessToken;
  String? avatar;
  late String email;
  late int cartsNum;
  late int customId;
  late int id;
  late String name;
  late int messagesNum;
  late String supportBoardLogin;
  late String tokenType;
  late String teamName;
  late String teamCode;
  late int companyId;

  TokenModel({
    required this.accessToken,
    required this.avatar,
    required this.email,
    required this.cartsNum,
    required this.customId,
    required this.id,
    required this.messagesNum,
    required this.supportBoardLogin,
    required this.tokenType,
    required this.name,
    required this.teamName,
    required this.teamCode,
    required this.companyId,
  });

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    email = json['email'];
    if (json['avatar'] != null) {
      avatar = json['avatar'];
    } else {
      avatar = '';
    }
    name = json['name'];
    id = json['id'];
    tokenType = json['token_type'];
    teamName = json['team_name'];
    teamCode = json['team_code'];
    companyId = json['company_id'];
  }
}
