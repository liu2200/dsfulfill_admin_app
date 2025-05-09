class CompanyModel {
  late int id;
  late String createdAt;
  late String inviteCode;
  late String teamName;
  late String teamCode;
  late String teamImage;

  CompanyModel({
    required this.id,
    required this.createdAt,
    required this.inviteCode,
    required this.teamName,
    required this.teamCode,
    required this.teamImage,
  });

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    inviteCode = json['invite_code'];
    teamName = json['team_name'];
    teamCode = json['team_code'];
    teamImage = json['team_image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'inviteCode': inviteCode,
      'teamName': teamName,
      'teamCode': teamCode,
      'teamImage': teamImage,
    };
  }
}
