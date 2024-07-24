import 'package:flutter/material.dart';

import '../../services/gpt_service.dart';
import '../components/appbar.dart';
import '../components/navigate_bar.dart';

class ReceiptAnalysis extends StatefulWidget {
  const ReceiptAnalysis({super.key});

  @override
  State<ReceiptAnalysis> createState() => _ReceiptAnalysisState();
}

class _ReceiptAnalysisState extends State<ReceiptAnalysis> {
  TextEditingController _inputController = TextEditingController();
  String _response = '';
  bool _isLoading = false;
  final GptService _gptService = GptService();

  Future<void> _sendPrompt() async {
    setState(() {
      _isLoading = true;
      _response = '';
    });

    final response = await _gptService.sendPrompt(_inputController.text);

    setState(() {
      _response = response;
      _isLoading = false;
      _inputController.clear(); // TextField içeriğini temizleme
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                const Appbar(appbarText: "FİŞ ANALİZ"),
                if (_isLoading)
                  const CircularProgressIndicator()
                else if (_response.isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Image.asset(
                      "lib/assets/images/logo.png",
                      width: 100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        "Nasıl yardımcı olabiliriz?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      "Örneğin \"En çok alışveriş yaptığım market neresidir?\" diye sorabilirsiniz",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "MontserratRegular",
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ] else
                  Container(
                    height: 350,
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SingleChildScrollView(
                      child: Text(
                        _response,
                        style: const TextStyle(
                          fontFamily: "MontserratRegular",
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextField(
                      controller: _inputController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _sendPrompt,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const NavigateBar(page: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
