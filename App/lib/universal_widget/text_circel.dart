import 'package:flutter/material.dart';

class CircleElement extends StatelessWidget {
  const CircleElement({super.key});

  @override
  Widget build(BuildContext context) {
    return (Container(
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: [Color(0xFF8983F7), Color(0xFFA3DAFB)],
                begin: Alignment.topRight,
                end: Alignment.topRight))));
  }
}
