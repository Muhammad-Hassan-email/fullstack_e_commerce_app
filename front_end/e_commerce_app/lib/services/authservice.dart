import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  static const String baseUrl = "http://10.0.2.2:5000/api/auth";

  // REGISTER
  Future<Map<String, dynamic>> registerUser(
      String name, String email, String password) async {

    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  // LOGIN
  Future<Map<String, dynamic>> loginUser(
      String email, String password) async {

    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }
}