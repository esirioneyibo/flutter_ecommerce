import 'package:http/http.dart' as http;

final baseUrl = 'http://localhost:1337/products';
final api = new http.Client();

Future getProducts() => api.get(baseUrl);
