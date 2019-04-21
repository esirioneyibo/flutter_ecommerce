import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/login_page.dart';
import 'package:flutter_ecommerce/pages/products_page.dart';
import 'package:flutter_ecommerce/pages/register_page.dart';

final routes = {
  '/products': (BuildContext context) => ProductsPage(),
  '/login': (BuildContext context) => LoginPage(),
  '/register': (BuildContext context) => RegisterPage()
};

final homePage = LoginPage();
