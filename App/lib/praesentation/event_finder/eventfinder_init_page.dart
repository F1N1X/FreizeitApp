import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/event_finder_bloc/bloc/event_finder_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/event_finder/eventfinder_initial_state.dart';

class InitFinder extends StatelessWidget {
  const InitFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<EventFinderBloc>(),
      child: BlocBuilder<EventFinderBloc, EventFinderState>(
        builder: (context, state) {
          return const EventFinderInitialWidget();
        },
      ),
    );
  }
}
