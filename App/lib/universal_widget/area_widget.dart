import 'package:flutter/material.dart';

class AreaWidget extends StatelessWidget {
  const AreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(246, 252, 250, 250),
          border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255), width: 1),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Guten Morgen",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontFamily: "Rubik",
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Schön dass du da bist!",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontFamily: "Rubik",
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Wähle unten eine Option aus!",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontFamily: "Rubik",
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.green,
                  height: 60,
                  child: const Placeholder(),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
