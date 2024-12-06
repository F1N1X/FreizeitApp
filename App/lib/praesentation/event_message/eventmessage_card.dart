import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final String message;
  const GroupCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(message),
            const Expanded(child: SizedBox()),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: const Icon(Icons.message_sharp, size: 30),
            ),
            const SizedBox(
              width: 30,
            )
          ],
        ),
      ),
    );
  }
}
