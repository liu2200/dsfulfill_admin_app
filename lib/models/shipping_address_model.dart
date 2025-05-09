class ShippingAddressModel {
  late int id;
  late String address1;
  late String address2;
  late String city;
  late String country;
  String countryCode = '';
  late String createdAt;
  late String firstName;
  late String lastName;
  late String name;
  late String phone;
  late String province;
  late String provinceCode;
  late String updatedAt;
  late String zip;
  late String email;
  ShippingAddressModel({
    required this.id,
    required this.address1,
    required this.address2,
    required this.city,
    required this.country,
    required this.countryCode,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.phone,
    required this.province,
    required this.provinceCode,
    required this.updatedAt,
    required this.zip,
    required this.email,
  });

  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address1 = json['address1'];
    address2 = json['address2'] ?? '';
    city = json['city'];
    country = json['country'];
    countryCode = json['country_code'] ?? '';
    createdAt = json['created_at'];
    firstName = json['first_name'];
    lastName = json['last_name'] ?? '';
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    province = json['province'];
    provinceCode = json['province_code'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    zip = json['zip'] ?? '';
    email = json['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address1': address1,
      'address2': address2,
      'city': city,
      'country': country,
      'country_code': countryCode,
      'created_at': createdAt,
      'first_name': firstName,
      'last_name': lastName,
      'name': name,
      'phone': phone,
      'province': province,
      'province_code': provinceCode,
      'updated_at': updatedAt,
      'zip': zip,
      'email': email,
    };
  }
}
