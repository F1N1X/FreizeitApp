import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/verification/bloc/verification_bloc.dart';

import '../../routes/router.gr.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerify = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    //BlocProvider.of<VerificationBloc>(context).add(CheckVerification());
    //isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerify) {
      timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => BlocProvider.of<VerificationBloc>(context)
              .add(CheckVerification()));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
/*
  Future checkEmailVerify() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerify) {
      timer?.cancel();
    }
  }
  */

  Future sendDelay() async {
    setState(() {
      canResendEmail = false;
    });
    await Future.delayed(const Duration(seconds: 10));

    setState(() {
      canResendEmail = true;
    });
  }

  void setVerified(bool newState) {
    setState(() {
      isEmailVerify = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationBloc, VerifiedState>(
      listener: (context, state) {
        state.failedOrIsVerified.fold(
            () => {},
            (failOrChanged) => failOrChanged.fold(
                (failure) => {},
                (isVerifiedBool) => {
                      if (isVerifiedBool)
                        {
                          setVerified(isVerifiedBool),
                          //AutoRouter.of(context)
                          //.replace(const WelcomePageRoute())
                        }
                    }));
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Eine Emailbestätigung wurde gesendet",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 26,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    if (canResendEmail) {
                      BlocProvider.of<VerificationBloc>(context)
                          .add(ResendMail());
                      sendDelay();
                    }
                  },
                  icon: const Icon(
                    Icons.email,
                    size: 30,
                  ),
                  label: const Text("Neue Mail senden")),
              const SizedBox(
                height: 7,
              ),
              TextButton(
                  //State und löschen
                  onPressed: () {
                    BlocProvider.of<VerificationBloc>(context)
                        .add(CancelVerification());
                    AutoRouter.of(context).replace(const RegisterPageRoute());
                  },
                  child: const Text(
                    "Abbrechen",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
