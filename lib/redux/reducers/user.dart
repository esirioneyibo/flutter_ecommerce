import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/redux/actions/user.dart';

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) return action.user;

  return user;
}
