import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/login_model.dart';

class Logincontroller {
  late LoginModel user;

  Logincontroller() {
    user = LoginModel(
      phoneNumber: "",
      password: "",
    );
  }

  void setPhoneNumber(String value) {
    user.phoneNumber = value;
  }

  void setPassword(String value) {
    user.password = value;
  }

  String? validateFields() {
    if (user.phoneNumber.isEmpty) {
      return "Lütfen Telefon numarası alanını doldurunuz";
    }

    if (user.password.isEmpty) {
      return "Lütfen Şifre alanını doldurunuz";
    }

    if (user.password.length < 8) {
      return "Şifreniz minimum 8 karakter uzunluğunda olmalıdır";
    }

    return null;
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<String?> login() async {
    final url = Uri.parse('http://35.202.100.38:8080/api/User/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': user.phoneNumber,
        'password': user.password,
      }),
    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      var token = responseBody['token'];
      print('Normal giriş yapan kullanıcı Token: $token');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      return response.statusCode.toString();
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    }
  }
}
