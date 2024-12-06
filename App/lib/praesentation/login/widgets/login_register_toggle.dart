import 'package:flutter/material.dart';

class ToggleLogin extends StatelessWidget {
  const ToggleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [true, false];
    return ToggleButtons(
        // list of booleans
        isSelected: isSelected,
        // text color of selected toggle
        selectedColor: Colors.white,
        // text color of not selected toggle
        color: Colors.grey,
        // fill color of selected toggle
        fillColor: Colors.blue,
        // when pressed, splash color is seen
        splashColor: Colors.blue,
        // long press to identify highlight color
        highlightColor: Colors.blue,
        // if consistency is needed for all text style
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        // border properties for each toggle
        renderBorder: true,
        borderColor: Colors.grey,
        borderWidth: 1,
        borderRadius: BorderRadius.circular(40),
        selectedBorderColor: Colors.grey,

// add widgets for which the users need to toggle
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('LOGIN', style: TextStyle(fontSize: 26)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('REGISTER', style: TextStyle(fontSize: 26)),
          ),
        ],
// to select or deselect when pressed
        onPressed: (int newIndex) {});
  }
}
