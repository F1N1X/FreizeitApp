import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/update_event/update_event_data.dart';

import '../../application/event_update_bloc/bloc/eventupdate_bloc.dart';

class InitialEventUpdate extends StatelessWidget {
  final Event event;
  const InitialEventUpdate({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => serviceLocator<EventupdateBloc>()
          ..add(EventUpdateInitial(event: event)),
        child: const UpdateEventForm());
  }
}
