import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/redux/actions/product.dart';

dynamic productsReducer(products, dynamic action) {
  if (action is GetProductsAction) return action.products;

  return products;
}
