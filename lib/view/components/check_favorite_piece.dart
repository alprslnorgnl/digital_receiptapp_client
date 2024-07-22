import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login.dart';
import '../screens/see_favorite_data.dart';
import '../screens/zero_favorite.dart';

class CheckFavoritePiece extends StatefulWidget {
  const CheckFavoritePiece({super.key});

  @override
  State<CheckFavoritePiece> createState() => _CheckFavoritePieceState();
}

class _CheckFavoritePieceState extends State<CheckFavoritePiece> {
  @override
  void initState() {
    super.initState();
    _fetchFavoriteCount();
  }

  Future<void> _fetchFavoriteCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    if (token.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
      return;
    }

    final response = await http.get(
      Uri.parse('http://35.202.100.38:8080/api/Receipt/favCount'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final receiptCount = data['favoriteCount'];
      if (receiptCount == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ZeroFavorite()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SeeFavoriteData()),
        );
      }
    } else {
      // Hata durumunda işlem yap
      print('Fiş sayısı alınırken hata oluştu: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
