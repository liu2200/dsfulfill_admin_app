class ProfileModel {
  late String avatar;
  late int id;
  late String phone;
  late String name;

  ProfileModel({
    required this.avatar,
    required this.id,
    required this.phone,
    required this.name,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'id': id,
      'phone': phone,
      'name': name,
    };
  }
}
