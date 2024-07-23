import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GptService {
  final String baseUrl = 'http://10.0.2.2:5109/api/Receipt';

  Future<String> sendPrompt(String prompt) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      return 'JWT token bulunamadı. Lütfen tekrar giriş yapın.';
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/gpt'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'prompt': prompt}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['analysis'] ?? 'Boş yanıt döndü.';
      } else {
        return 'Fiş analizi yapılırken bir hata oluştu.';
      }
    } catch (e) {
      return 'Bir hata oluştu: $e';
    }
  }
}
