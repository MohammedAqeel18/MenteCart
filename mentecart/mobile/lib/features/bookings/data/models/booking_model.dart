class BookingModel {

  final String id;

  final String status;

  final int totalAmount;

  final String createdAt;

  BookingModel({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
  });

  factory BookingModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return BookingModel(
      id: json['_id'],

      status: json['status'],

      totalAmount:
          json['totalAmount'],

      createdAt:
          json['createdAt'],
    );
  }
}