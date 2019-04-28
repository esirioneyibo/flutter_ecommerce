import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductsPage extends StatefulWidget {
  static const ROUTE = '/products';

  final void Function() onInit;

  ProductsPage({this.onInit});
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  final Widget _appBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          title: SizedBox(
            child: Text(state.user != null ? state.user.username : ""),
          ),
          leading: Icon(Icons.store),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: state.user != null
                  ? IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () => print("pressed"),
                    )
                  : Text(""),
            )
          ],
        );
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Container(
        child: Text('Welcome to products page!'),
      ),
    );
  }
}
