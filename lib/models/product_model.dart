class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
      category: json["category"],
      image: json["image"],
      rating: (json["rating"]["rate"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "category": category,
      "image": image,
      "rating": rating,
    };
  }

  factory ProductModel.fromMap(Map map) {
    return ProductModel(
      id: map["id"],
      title: map["title"],
      price: (map["price"] as num).toDouble(),
      description: map["description"],
      category: map["category"],
      image: map["image"],
      rating: (map["rating"] as num).toDouble(),
    );
  }
}
