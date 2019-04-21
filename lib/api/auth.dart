import 'package:http/http.dart' as http;

final baseUrl = 'http://localhost:1337/auth/local';
final api = new http.Client();

Future registerUser(String username, String email, String password) =>
    api.post('$baseUrl/register',
        body: {"username": username, "email": email, "password": password});

Future loginUser(String identifier, String password) => api
    .post('$baseUrl', body: {"identifier": identifier, "password": password});
