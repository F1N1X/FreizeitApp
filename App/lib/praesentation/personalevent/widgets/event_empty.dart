import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../routes/router.gr.dart';

class EmptyEvents extends StatelessWidget {
  const EmptyEvents({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.blue,
          height: height / 4,
        ),
        const SizedBox(
          height: 70,
        ),
        Expanded(
          flex: 3,
          child: Image.asset(
            'lib/images/eventliste_center.png',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Expanded(
            flex: 1,
            child: Text(
              "Noch keine Events vorhanden",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'RobotoMono'),
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox.fromSize(
            size: const Size(100, 100),
            child: ClipOval(
              child: Material(
                color: Colors.blue,
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    AutoRouter.of(context).replace(const WelcomeScreenRoute());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.arrow_back),
                      Text(
                        "Zurück",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            letterSpacing: 2,
                            fontFamily: 'RobotoMono'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
