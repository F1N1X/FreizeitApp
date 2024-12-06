import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;

  //Funktion von außen rein geben
  final Function callback;

  const CustomButton(
      {super.key, required this.buttonText, required this.callback});

  @override
  Widget build(BuildContext context) {
//!Um Funktionen den Button zu hinterlegen oder felder zu button zu machen InkResponse
    return InkResponse(
      onTap: () => callback(),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          buttonText,
        )),
      ),
    );
  }
}
