import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/auth_checker/bloc/auth_bloc.dart';
import 'package:freizeit_app/application/event_form_bloc/bloc/event_form_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/eventcreation/event_creation_with_map.dart';
import 'package:freizeit_app/routes/router.gr.dart';

import '../../application/user_information/bloc/userinformation_bloc.dart';

class EventCreationFromWelcome extends StatelessWidget {
  const EventCreationFromWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              serviceLocator<EventFormBloc>()..add(InitialzeCreationForm()),
        ),
        BlocProvider(
          create: (context) =>
              serviceLocator<UserinformationBloc>()..add(GetUserGeoData()),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateUnAuthenticated) {
            AutoRouter.of(context).replace(const LoginPageRoute());
          }
        },
        child: const EventCreationWithMap(),
      ),
    );
  }
}
