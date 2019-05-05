import 'dart:convert';
import 'package:http/http.dart';

import '../api/products.dart' as productsApi;

Future<Map<String, dynamic>> getProducts() async {
  Response response = await productsApi.getProducts();
  final decodedResponse = json.decode(response.body);
  if (response.statusCode == 200)
    return {"ok": true, "products": decodedResponse};
  return handleError(decodedResponse);
}

Map<String, dynamic> handleError(responseData) {
  Map<String, dynamic> response = responseData;
  response.addAll({"ok": false});
  return response;
}
