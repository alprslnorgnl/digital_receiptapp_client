// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import '../../constants/colors.dart';

// class OtpInput extends StatefulWidget {
//   const OtpInput({super.key, required this.onCompleted});

//   final Function(String) onCompleted;

//   @override
//   State<OtpInput> createState() => _OtpInputState();
// }

// class _OtpInputState extends State<OtpInput> {
//   final List<TextEditingController> _controllers =
//       List.generate(6, (_) => TextEditingController()); // Updated to 6

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(6, (index) {
//           // Updated to 6
//           return SizedBox(
//             width: 50,
//             child: TextField(
//               controller: _controllers[index],
//               keyboardType: TextInputType.number,
//               maxLength: 1,
//               textAlign: TextAlign.center,
//               decoration: InputDecoration(
//                 counterText: "",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide(color: HexColor(buttonColor1)),
//                 ),
//               ),
//               style: TextStyle(
//                 fontFamily: "Montserrat",
//                 fontSize: 24.0,
//                 color: HexColor(fontColor1),
//               ),
//               onChanged: (value) {
//                 if (value.length == 1 && index < 5) {
//                   // Updated to 5
//                   FocusScope.of(context).nextFocus();
//                 }
//                 if (value.isEmpty && index > 0) {
//                   FocusScope.of(context).previousFocus();
//                 }
//                 if (index == 5 && value.isNotEmpty) {
//                   // Updated to 5
//                   String otp = _controllers.map((e) => e.text).join();
//                   widget.onCompleted(otp);
//                 }
//               },
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../constants/colors.dart';

class OtpInput extends StatefulWidget {
  const OtpInput({super.key, required this.onCompleted});

  final Function(String) onCompleted;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(6, (index) {
          return SizedBox(
            width: 50,
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: HexColor(buttonColor1)),
                ),
              ),
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 24.0,
                color: HexColor(fontColor1),
              ),
              onChanged: (value) {
                if (value.length == 1 && index < 5) {
                  FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                }
                if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                }
                if (index == 5 && value.isNotEmpty) {
                  String otp = _controllers.map((e) => e.text).join();
                  widget.onCompleted(otp);
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
