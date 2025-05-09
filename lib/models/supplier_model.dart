class SupplierModel {
  late int id;
  late String supplierName;
  SupplierModel({
    required this.id,
    required this.supplierName,
  });

  SupplierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierName = json['supplier_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'supplierName': supplierName,
    };
  }
}
