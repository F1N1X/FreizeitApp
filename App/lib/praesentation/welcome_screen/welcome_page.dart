import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/auth_checker/bloc/auth_bloc.dart';
import 'package:freizeit_app/application/user_information/bloc/userinformation_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/welcome_screen/welcome_screen.dart';
import 'package:freizeit_app/routes/router.gr.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userInformationBloc = serviceLocator<UserinformationBloc>()
      ..add(StartLoadUserInformation());
    return MultiBlocProvider(
        providers: [
          //direkt ausführen des ObserverAllEvent
          BlocProvider<UserinformationBloc>(
              create: (context) => userInformationBloc),
        ],
        //!Hören um auf Fehler zu reagieren
        child: MultiBlocListener(
          listeners: [
            //!Auf den Block höhren wenn der State nicht eingeloggt ist back auf SignUpPase sonst warten bis gedrückt wird

            BlocListener<AuthBloc, AuthState>(listener: ((context, state) {
              if (state is AuthStateUnAuthenticated) {
                AutoRouter.of(context).replace(const LoginPageRoute());
              }
            })),

            BlocListener<UserinformationBloc, UserInformationState>(
                listener: ((context, state) {
              if (state is StartLoadUserInformation) {
                const CircularProgressIndicator();
              }
            }))
          ],
          child: const WelcomePage(),
        ));
  }
}
