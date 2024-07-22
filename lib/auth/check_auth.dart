//Buradaki işlem basitçe şudur: widget ilk olarak çağrıldığında
//mevcutta bir tokenin kayıtlı olup olmadığı kontrol edilir.
//eğer değilse --> Welcome sayfasına
//eğer kayıtlıysa --> CheckReceiptPiece sayfasına yönlendirilir

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/components/check_receipt_piece.dart';
import '../view/screens/welcome.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('jwt_token') ?? '';

    if (token.isEmpty) {
      print('Oturum açılmamış, Welcome sayfasına yönlendiriliyor...');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Welcome()));
    } else {
      print('Oturum Tokeni: $token');
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CheckReceiptPiece()));
    }
  }
}
