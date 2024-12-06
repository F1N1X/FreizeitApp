import 'package:flutter/material.dart';

class EventDetailButton extends StatelessWidget {
  final Color textColor;
  final Color background;
  final Color borderColor;
  final String text;
  final IconData? icon;
  final double width;
  final double hight;
  final bool? isIcon;

  const EventDetailButton(
      {super.key,
      required this.width,
      required this.hight,
      required this.textColor,
      required this.background,
      required this.borderColor,
      required this.text,
      this.isIcon = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1.0)),
      child: Center(
          child: isIcon == false
              ? Text(
                  text,
                  style: TextStyle(color: textColor),
                )
              : Icon(
                  icon,
                  color: textColor,
                )),
    );
  }
}
