import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart'; // refactor this

import 'package:flutter_ecommerce/models/app_state.dart'; // refactor this

import 'package:flutter_ecommerce/pages/login_page.dart';
import 'package:flutter_ecommerce/pages/products_page.dart';
import 'package:flutter_ecommerce/pages/register_page.dart';

import 'package:flutter_ecommerce/redux/actions/product.dart'; // refactor this
import 'package:flutter_ecommerce/redux/actions/user.dart'; // refactor this

final routes = {
  ProductsPage.ROUTE: (BuildContext context) => ProductsPage(
        // TODO onInit function should be in other file
        onInit: () {
          StoreProvider.of<AppState>(context).dispatch(getUserAction);
          StoreProvider.of<AppState>(context).dispatch(getProductsAction);
        },
      ),
  LoginPage.ROUTE: (BuildContext context) => LoginPage(),
  RegisterPage.ROUTE: (BuildContext context) => RegisterPage()
};

final homePage = LoginPage();
