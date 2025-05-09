class ExpressLinesModel {
  late int id;
  late String name;
  ExpressLinesModel({
    required this.id,
    required this.name,
  });

  ExpressLinesModel.fromJson(Map<String, dynamic> json) {
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
