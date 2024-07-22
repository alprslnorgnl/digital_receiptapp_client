import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OcrService {
  final String _ocrApiUrl = 'http://35.202.100.38:8080/api/Receipt/ocr';
  final String _addReceiptApiUrl =
      'http://35.202.100.38:8080/api/Receipt/addReceipt';

  Future<Map<String, dynamic>?> pickImageAndExtractText() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);

      final request = http.MultipartRequest('POST', Uri.parse(_ocrApiUrl));
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      if (responseBody.statusCode == 200) {
        return jsonDecode(responseBody.body);
      } else {
        // Handle error
        return null;
      }
    } else {
      // Handle file not selected error
      return null;
    }
  }

  Future<bool> saveReceipt(Map<String, dynamic> receiptData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final response = await http.post(
      Uri.parse(_addReceiptApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(receiptData),
    );

    return response.statusCode == 200;
  }
}
