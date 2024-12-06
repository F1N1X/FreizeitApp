import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/auth_checker/bloc/auth_bloc.dart';
import 'package:freizeit_app/application/event_bloc/bloc/event_bloc.dart';
import 'package:freizeit_app/praesentation/personalevent/widgets/event_body.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/routes/router.gr.dart';

class PersonalEventPage extends StatelessWidget {
  const PersonalEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventBloc = serviceLocator<EventBloc>()
      ..add(LoadingSubscripedEvent());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => eventBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: ((context, state) {
            if (state is AuthStateUnAuthenticated) {
              AutoRouter.of(context).replace(const LoginPageRoute());
            }
          })),
          BlocListener<EventBloc, EventState>(listener: ((context, state) {
            //!Failhandling
          }))
        ],
        child: Scaffold(
          backgroundColor: Colors.blue[200],
          body: const EventBody(),
        ),
      ),
    );
  }
}
//Listview später
