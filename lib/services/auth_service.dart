import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class AuthService {
  Future<User?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://dummyjson.com/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username.trim(),
          'password': password.trim(),
        }),
      );

      // DEBUG: cetak log respons
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        // Tangani respons gagal (401 atau lainnya)
        print('Login gagal. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Tangani error jaringan, JSON, dll
      print('Terjadi error saat login: $e');
      return null;
    }
  }
}
