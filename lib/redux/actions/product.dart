import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/models/product.dart';

import 'package:flutter_ecommerce/services/product.dart' as productService;

/* GetProductsAction */
ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  final Map<String, dynamic> response = await productService.getProducts();
  if (response['ok']) store.dispatch(GetProductsAction(response['products']));
};

class GetProductsAction {
  final List<dynamic> _products;

  List get products => this._products;

  GetProductsAction(this._products);
}
