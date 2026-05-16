class ServiceModel {
  final String id;
  final String title;
  final String description;
  final int price;
  final String category;
  final String image;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });

  factory ServiceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ServiceModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      image: json['image'],
    );
  }
}