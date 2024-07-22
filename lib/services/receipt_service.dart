import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Receipt_model.dart';

class ReceiptService {
  final String _baseUrl = 'http://35.202.100.38:8080/api/Receipt';

  Future<List<ReceiptModel>> getReceipts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final response = await http.get(
      Uri.parse('$_baseUrl/all'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ReceiptModel> receipts =
          data.map((item) => ReceiptModel.fromJson(item)).toList();
      receipts.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return receipts;
    } else {
      throw Exception('Failed to load receipts');
    }
  }

  Future<bool> addReceipt(ReceiptModel receipt) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final response = await http.post(
      Uri.parse('$_baseUrl/addReceipt'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(receipt),
    );

    return response.statusCode == 200;
  }

  Future<bool> updateReceipt(int id, ReceiptModel receipt) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final response = await http.put(
      Uri.parse('$_baseUrl/update/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(receipt),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteReceipt(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final response = await http.delete(
      Uri.parse('$_baseUrl/delete/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response.statusCode == 200;
  }

  Future<bool> toggleFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final response = await http.post(
      Uri.parse('$_baseUrl/toggleFavorite/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response.statusCode == 200;
  }

  Future<List<ReceiptModel>> getFavoriteReceipts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final response = await http.get(
      Uri.parse('http://35.202.100.38:8080/api/Receipt/getAllFav'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ReceiptModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load favorite receipts');
    }
  }
}
