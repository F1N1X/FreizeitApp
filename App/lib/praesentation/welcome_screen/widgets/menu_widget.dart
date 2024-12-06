import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final String widgetSubtitle;
  final String iconAssetPath;
  final Function onPressed;

  const MenuWidget(
      {super.key,
      required this.onPressed,
      required this.widgetSubtitle,
      required this.iconAssetPath});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
          height: 150,
          width: 150,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(iconAssetPath),
                    ),
                  ),
                ),
              ),
              Text(
                widgetSubtitle,
                style: TextStyle(color: Colors.grey[800], fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
