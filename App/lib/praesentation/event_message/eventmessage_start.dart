import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/auth_checker/bloc/auth_bloc.dart';
import 'package:freizeit_app/application/message_handling/bloc/message_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/event_message/eventmessage_page.dart';
import 'package:freizeit_app/routes/router.gr.dart';

class EventMessagesPage extends StatelessWidget {
  final String id;
  const EventMessagesPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<MessageBloc>()..add(LoadEventForMessage(id: id)),
      child: MultiBlocListener(listeners: [
        BlocListener<AuthBloc, AuthState>(listener: ((context, state) {
          if (state is AuthStateUnAuthenticated) {
            AutoRouter.of(context).replace(const LoginPageRoute());
          }
        })),
        BlocListener<MessageBloc, MessageState>(
          listener: (context, state) {},
        )
      ], child: const EventChat()),
    );
  }
}
