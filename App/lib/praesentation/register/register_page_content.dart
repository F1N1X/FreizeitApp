import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/register_handling/bloc/register_bloc.dart';
import 'package:freizeit_app/routes/router.gr.dart';

class RegisterArea extends StatelessWidget {
  const RegisterArea({super.key});

  @override
  Widget build(BuildContext context) {
    late String email;
    late String password;
    final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String? validateEmail(String? inputMail) {
      if (inputMail != null && EmailValidator.validate(inputMail)) {
        email = inputMail;
      } else {
        return "Falsches Format";
      }
      return null;
    }

    String? validatePassword(String? inputPassword) {
      if (inputPassword == null || inputPassword.isEmpty) {
        return "Password not valid";
      } else if (inputPassword.length < 6) {
        return "Password to short";
      } else {
        password = inputPassword;
      }
      return null;
    }

    return BlocConsumer<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) =>
          previous.registerOrFailure != current.registerOrFailure,
      listener: (context, state) {
        state.registerOrFailure.fold(
            () => {},
            (failedOrSucced) => failedOrSucced.fold(
                (failure) => {
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
                            'lib/images/register_top.png',
                            scale: 5,
                          ),
                          const FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              "Registrieren",
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
                                key: formKey2,
                                child: ListView(
                                  children: [
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
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
                                      height: 10,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
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
                                      height: 10,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      validator: validatePassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
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
                                          labelText: "Passwort wiederholen"),
                                      cursorColor: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    FloatingActionButton.extended(
                                      label: const Text(
                                        'Jetzt Registrieren',
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
                                        if (formKey2.currentState!.validate()) {
                                          BlocProvider.of<RegisterBloc>(context)
                                              .add(
                                                  RegisterWithEmailAndPasswordPressed(
                                                      email: email,
                                                      password: password));
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                            "Du hast schon einen Account?",
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
                                                  const LoginPageRoute());
                                            },
                                            child: const Text(
                                              "Hier einloggen",
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
                      child: Align(
                        alignment: Alignment.center,
                        child:
                            Image.asset('lib/images/register_bottom_left.png'),
                      ),
                    ),
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
