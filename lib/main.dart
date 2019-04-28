import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/redux/reducers/reducers.dart';

import './routes.dart' as Routes;
import './theme/app_theme.dart' as Theme;

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);
  return runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        routes: Routes.routes,
        title: 'Barger\'s',
        theme: Theme.appTheme,
        home: Routes.homePage,
      ),
    );
  }
}
