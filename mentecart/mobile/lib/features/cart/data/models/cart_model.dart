class CartItemModel {

  final String id;

  final String serviceTitle;

  final String image;

  final int quantity;

  final int price;

  final String date;

  final String timeSlot;

  CartItemModel({
    required this.id,
    required this.serviceTitle,
    required this.image,
    required this.quantity,
    required this.price,
    required this.date,
    required this.timeSlot,
  });

  factory CartItemModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return CartItemModel(
      id: json['_id'],

      serviceTitle:
          json['service']['title'],

      image:
          json['service']['image'],

      quantity: json['quantity'],

      price:
          json['service']['price'],

      date: json['date'],

      timeSlot: json['timeSlot'],
    );
  }
}