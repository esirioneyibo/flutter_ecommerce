import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

import '../api/auth.dart' as authApi;

Future<Map<String, dynamic>> loginUser(identifier, password) async {
  Response response = await authApi.loginUser(identifier, password);
  final decodedResponse = json.decode(response.body);
  if (response.statusCode == 200) return handleAuthSuccess(decodedResponse);
  return handleAuthError(decodedResponse);
}

Future<Map<String, dynamic>> registerUser(username, email, password) async {
  Response response = await authApi.registerUser(username, email, password);
  final decodedResponse = json.decode(response.body);
  if (response.statusCode == 200) return handleAuthSuccess(decodedResponse);
  return handleAuthError(decodedResponse);
}

Map<String, dynamic> handleAuthSuccess(responseData) {
  _storeUserData(responseData);
  Map<String, dynamic> response = responseData;
  responseData['ok'] = true;
  return response;
}

Map<String, dynamic> handleAuthError(responseData) {
  Map<String, dynamic> response = responseData;
  responseData['ok'] = false;
  return response;
}

void _storeUserData(responseData) async {
  final prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> user = responseData['user'];
  user.putIfAbsent('jwt', () => responseData['jwt']);
  prefs.setString('user', json.encode(user));
}
