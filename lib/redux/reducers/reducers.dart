import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/redux/reducers/user.dart';
import 'package:flutter_ecommerce/redux/reducers/product.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      user: userReducer(state.user, action),
      products: productsReducer(state.products, action));
}
