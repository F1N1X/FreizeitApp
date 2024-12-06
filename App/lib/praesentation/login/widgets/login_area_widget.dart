import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/routes/router.gr.dart';

import '../../../application/login_handling/bloc/login_bloc.dart';

class LoginArea extends StatelessWidget {
  const LoginArea({super.key});

  @override
  Widget build(BuildContext context) {
    late String email;
    late String password;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool startValidation = false;
    // int size = 160;
    // double buttonSize = height / 3;
    //double topSize = height / 3;
    //double centerSize = height / 3;

    String? validateEmail(String? input) {
      const emailRegex =
          r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
      if (input == null || input.isEmpty) {
        return "Please enter email";
      } else if (RegExp(emailRegex).hasMatch(input)) {
        email = input;
        return null;
      } else {
        return "invalid email format";
      }
    }

    String? validatePassword(String? input) {
      if (input == null || input.isEmpty) {
        return "Please enter password";
      } else if (input.length >= 6) {
        password = input;
        return null;
        //!return null ist ok
      } else {
        return "short password";
      }
    }

    return BlocConsumer<LoginBloc, SignUpState>(
      listenWhen: (previous, current) =>
          previous.authFailedOrSucced != current.authFailedOrSucced,
      listener: (context, state) {
        state.authFailedOrSucced.fold(
            () => {
                  //none fall
                },
            (failedOrSucced) => failedOrSucced.fold(
                (failure) => {
                      startValidation = true,
                      //Errorhandling für Fehlernachrichten
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(failure.toString())))
                    },
                (succed) => {
                      AutoRouter.of(context).replace(const WelcomeScreenRoute())
                    }));
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Image.asset(
                            'lib/images/login.png',
                            scale: 5,
                          ),
                          const FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              "Anmelden",
                              style: TextStyle(
                                letterSpacing: 3,
                                color: Color.fromARGB(255, 126, 126, 126),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 3,
                      child: Container(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                                key: formKey,
                                child: ListView(
                                  children: [
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextFormField(
                                      autovalidateMode: startValidation
                                          ? AutovalidateMode.always
                                          : AutovalidateMode.disabled,
                                      obscureText: false,
                                      validator: validateEmail,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          iconColor: Colors.grey,
                                          fillColor: Colors.white,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          labelStyle: const TextStyle(
                                              color: Colors.grey),
                                          filled: true,
                                          prefixIcon:
                                              const Icon(Icons.email_outlined),
                                          labelText: "EMAIL"),
                                      cursorColor: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      autovalidateMode: startValidation
                                          ? AutovalidateMode.always
                                          : AutovalidateMode.disabled,
                                      obscureText: true,
                                      validator: validatePassword,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          iconColor: Colors.grey[850],
                                          fillColor: Colors.white,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          labelStyle: const TextStyle(
                                              color: Colors.grey),
                                          filled: true,
                                          prefixIcon:
                                              const Icon(Icons.lock_rounded),
                                          labelText: "Passwort"),
                                      cursorColor: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    FloatingActionButton.extended(
                                      label: const Text(
                                        'Anmelden',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 126, 126, 126),
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
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<LoginBloc>(context).add(
                                              SignInWithEmailAndPasswordPressed(
                                                  email: email,
                                                  password: password));
                                        }
                                        startValidation = true;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("Noch kein Account?",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.none,
                                                fontSize: 10)),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        DefaultTextStyle(
                                          style: const TextStyle(
                                              letterSpacing: 1,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              AutoRouter.of(context).replace(
                                                  const RegisterPageRoute());
                                            },
                                            child: const Text(
                                              "Hier erstellen",
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ))),
                  Flexible(
                    flex: 1,
                    child: Container(
                        color: Colors.white,
                        child: Row(children: [
                          Expanded(
                              child: Image.asset(
                                  'lib/images/login_bottom_left.png')),
                          Expanded(
                              child: Image.asset(
                                  'lib/images/login_bottom_right1.png')),
                          Expanded(
                              child: Image.asset(
                                  'lib/images/login_bottom_right2.png')),
                        ])),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
