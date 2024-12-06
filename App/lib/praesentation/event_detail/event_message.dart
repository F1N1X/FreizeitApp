import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 236, 239, 243),
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
            ),
            height: 130,
            width: 100,
            child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          message,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 44, 43, 43),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontFamily: 'RobotoMono'),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
