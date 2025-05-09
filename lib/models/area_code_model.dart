class AreaCodeModel {
  int? id;
  String name;
  String code;
  String? code2;

  AreaCodeModel({
    this.id,
    required this.name,
    required this.code,
    this.code2,
  });

  AreaCodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? '',
        code = json['code'] ?? '',
        code2 = json['code2'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'code2': code2,
    };
  }
}
