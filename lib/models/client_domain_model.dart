class ClientDomainModel {
  late int id;
  late String domain;

  ClientDomainModel({
    required this.id,
    required this.domain,
  });

  ClientDomainModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'domain': domain,
    };
  }
}
