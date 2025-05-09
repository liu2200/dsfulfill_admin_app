class CountryModel {
  late int id;
  late String name;

  CountryModel({
    required this.id,
    required this.name,
  });

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
