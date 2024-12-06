import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/routes/router.gr.dart';

import '../../application/auth_checker/bloc/auth_bloc.dart';

class LoginSplashPage extends StatelessWidget {
  const LoginSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Höhren auf AuthBloc mit Auth State
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAuthenticated) {
          //navigate to Home
          AutoRouter.of(context).replace(const WelcomeScreenRoute());
        } else if (state is AuthStateUnAuthenticated) {
          //navigate to SignIn
          AutoRouter.of(context).replace(const StartPageRoute());
        }
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
//anzeigen während entscheiden wird ob schon eingeloggt