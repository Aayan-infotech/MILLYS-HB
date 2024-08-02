class SubCategory {
  String title;
  String id;
  String pictureUrl;
  String categoryId;
  int stock;

  SubCategory({
    required this.title,
    required this.id,
    required this.pictureUrl,
    required this.categoryId,
    required this.stock,
  });

  // Convert a SubCategory object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'pictureUrl': pictureUrl,
      'stock': stock,
    };
  }

  // Create a SubCategory object from a JSON map
  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      categoryId: json['json'],
      title: json['title'],
      id: json['_id'],
      pictureUrl: json['image'],
      stock: json['stock'],
    );
  }
}
