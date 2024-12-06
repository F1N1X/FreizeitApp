import 'package:flutter/material.dart';

class GreetingArea extends StatelessWidget {
  final String? userMail;

  const GreetingArea({super.key, this.userMail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 7,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('lib/images/welcomepage_top.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Willkommen",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Satoshi",
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            Text(
              userMail!,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Satoshi",
                  letterSpacing: 2,
                  fontSize: 21),
            ),
          ],
        ),
      ),
    );
  }
}
