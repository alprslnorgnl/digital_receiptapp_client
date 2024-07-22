import 'package:flutter/material.dart';

class AppbarWithArrow extends StatelessWidget {
  const AppbarWithArrow({super.key, required this.appbarText, this.detailPage});

  final String appbarText;
  final bool? detailPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (detailPage == true) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    appbarText,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontFamily: "MontserratRegular",
                        fontSize: 18.0,
                        letterSpacing: 8.0),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
