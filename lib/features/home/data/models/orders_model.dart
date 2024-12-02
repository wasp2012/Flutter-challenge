import 'dart:convert';

class OrdersModel {
  final String id;
  final bool isActive;
  final double price;
  final String company;
  final String picture;
  final String buyer;
  final List<String> tags;
  final String status;
  final DateTime registered;

  OrdersModel(
      {required this.id,
      required this.isActive,
      required this.price,
      required this.company,
      required this.picture,
      required this.buyer,
      required this.tags,
      required this.status,
      required this.registered});

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json['id'],
      isActive: json['isActive'],
      price: double.parse(
          (json['price'] as String).replaceAll(r'$', '').replaceAll(',', '')),
      company: json['company'],
      picture: json['picture'],
      buyer: json['buyer'],
      tags: List<String>.from(json['tags']),
      status: json['status'],
      registered: DateTime.parse(json['registered'].split(' ')[0]),
    );
  }
}

List<OrdersModel> parseOrders(String jsonData) {
  final data = json.decode(jsonData) as List;
  return data.map((e) => OrdersModel.fromJson(e)).toList();
}
