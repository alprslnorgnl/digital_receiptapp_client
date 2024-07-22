import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import '../model/signup_model.dart';

class SignupController {
  late SignupModel user;

  SignupController() {
    user = SignupModel(
      phoneNumber: "",
      password: "",
      checkboxValue: false,
    );
  }

  void setPhoneNumber(String value) {
    user.phoneNumber = value;
  }

  void setPassword(String value) {
    user.password = value;
  }

  void setCheckboxValue(bool value) {
    user.checkboxValue = value;
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

    if (!user.checkboxValue) {
      return "Lütfen onay kutusunu işaretleyin";
    }

    return null;
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<String?> signup() async {
    final url = Uri.parse('http://35.202.100.38:8080/api/User/signup');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'PhoneNumber': user.phoneNumber,
        'Password': user.password,
      }),
    );

    if (response.statusCode == 200) {
      return response.statusCode.toString();
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    }
  }
}
