import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/application/auth_checker/bloc/auth_bloc.dart';
import 'package:freizeit_app/application/event_finder_bloc/bloc/event_finder_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/event_finder/eventfinder_showing_results.dart';
import 'package:freizeit_app/routes/router.gr.dart';

class LoadingEventFinder extends StatelessWidget {
  final List<Event> eventList;
  const LoadingEventFinder({super.key, required this.eventList});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<EventFinderBloc>()
            ..add(LoadingFoundedEvents(eventList: eventList)),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: ((context, state) {
            if (state is AuthStateUnAuthenticated) {
              AutoRouter.of(context).replace(const LoginPageRoute());
            }
          })),
        ],
        child: Scaffold(
          backgroundColor: Colors.blue[200],
          body: const EventFinderSearchingBody(),
        ),
      ),
    );
  }
}
