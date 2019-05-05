import 'package:meta/meta.dart';

class Product {
  String id;
  String name;
  String description;
  String picture;
  double price;

  Product(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.price,
      @required this.picture});

  factory Product.fromJson(Map<String, dynamic> jsonProduct) {
    return Product(
        id: jsonProduct['_id'],
        name: jsonProduct['name'],
        description: jsonProduct['description'],
        price: jsonProduct['price'],
        picture: jsonProduct['picture']);
  }
}
