class ProductsModel {
  ProductsModel({required this.products});

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    products: (json['products'] as List<dynamic>)
        .map((item) => Products.fromJson(item))
        .toList(),
  );

  final List<Products> products;
}

class Products {
  Products({required this.id, required this.title, required this.description});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    description: json['description'] ?? '',
  );

  final int id;
  final String title;
  final String description;
}
