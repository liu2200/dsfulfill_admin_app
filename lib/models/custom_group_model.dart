class CustomGroupModel {
  late int id;
  late String groupName;
  late String description;
  late int customCount;

  CustomGroupModel({
    required this.id,
    required this.groupName,
    required this.description,
    required this.customCount,
  });

  CustomGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
    description = json['description'];
    customCount = json['custom_count'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_name': groupName,
      'description': description,
      'custom_count': customCount,
    };
  }
}
