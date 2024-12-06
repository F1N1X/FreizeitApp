import 'package:flutter/material.dart';

class EventDetailTextField extends StatelessWidget {
  final double width;
  final String firstText;
  final String eventText;

  const EventDetailTextField(
      {super.key,
      required this.width,
      required this.firstText,
      required this.eventText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 40, right: 40),
      child: Container(
        color: const Color.fromARGB(255, 228, 245, 253),
        height: 40,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 7,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Text(firstText,
                  style: const TextStyle(
                      fontSize: 14,
                      letterSpacing: 2,
                      color: Color.fromARGB(255, 2, 0, 136),
                      fontFamily: 'RobotoMono')),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(eventText,
                  style: const TextStyle(
                      fontSize: 14,
                      letterSpacing: 2,
                      color: Color.fromARGB(255, 2, 0, 136),
                      fontFamily: 'RobotoMono')),
            ),
          ],
        ),
      ),
    );
  }
}
