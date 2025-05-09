class GoodsCategoryModel {
  late int id;
  late String name;
  late int status;
  late int sort;
  late List<GoodsCategoryModel> categories;

  GoodsCategoryModel({
    required this.id,
    required this.name,
    required this.status,
    required this.sort,
    required this.categories,
  });

  GoodsCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    sort = json['sort'];

    // 安全处理categories，确保它不为null
    if (json['categories'] != null) {
      categories = (json['categories'] as List)
          .map((category) => GoodsCategoryModel.fromJson(category))
          .toList();
    } else {
      categories = []; // 如果为null，则初始化为空列表
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'sort': sort,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}
