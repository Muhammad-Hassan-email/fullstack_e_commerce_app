import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  static const String baseUrl = "http://10.0.2.2:5000/api/auth";

  // REGISTER
  Future<Map<String, dynamic>> registerUser(
      String fName, String lName, String phone, String address, String city, String state, String country, String email, String password) async {

    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
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