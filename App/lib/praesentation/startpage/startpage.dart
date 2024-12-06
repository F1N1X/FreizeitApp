import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:freizeit_app/routes/router.gr.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int size = 160;
    double buttonSize = height - (height / 2 + size);
    double topSize = (height / 2 + size);

    return Column(
      children: [
        Container(
          height: topSize,
          width: width,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  'lib/images/startlogo.png',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Anmelden",
                  style: TextStyle(
                      letterSpacing: 3,
                      color: Color.fromARGB(255, 126, 126, 126),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontSize: 50),
                ),
              )
            ],
          ),
        ),
        Container(
          height: buttonSize,
          width: width,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width - 50,
                child: FloatingActionButton.extended(
                  label: const Text(
                    'Jetzt Registrieren',
                    style: TextStyle(
                      color: Color.fromARGB(255, 126, 126, 126),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  icon: const Icon(
                    Icons.login_outlined,
                    size: 24.0,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    AutoRouter.of(context).replace(const RegisterPageRoute());
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Schon registriert?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontSize: 10)),
                  DefaultTextStyle(
                    style: const TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 10),
                    child: GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).replace(const LoginPageRoute());
                      },
                      child: const Text(
                        "Anmelden",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
