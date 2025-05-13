class CustomClientModel {
  late int id;
  late String createdAt;
  late String introduceVideo;
  late String logo;
  late String name;
  late String tabIcon;
  late String privacyPolicy;
  Map<String, dynamic>? color;

  CustomClientModel({
    required this.id,
    required this.createdAt,
    required this.introduceVideo,
    required this.logo,
    required this.name,
    required this.tabIcon,
    required this.privacyPolicy,
    this.color,
  });

  CustomClientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    introduceVideo = json['introduce_video'];
    logo = json['logo'];
    name = json['name'];
    tabIcon = json['tab_icon'];
    privacyPolicy = json['privacy_policy'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'introduce_video': introduceVideo,
      'logo': logo,
      'name': name,
      'tab_icon': tabIcon,
      'privacy_policy': privacyPolicy,
      'color': color,
    };
  }
}
