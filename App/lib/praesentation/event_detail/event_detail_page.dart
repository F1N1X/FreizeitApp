import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/application/event_detail/bloc/event_detail_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/event_detail/event_detail_form_map.dart';

class EventDetail extends StatelessWidget {
  final Event? event;
  const EventDetail({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<EventDetailBloc>()
        ..add(InitializeEventDetailPage(event)),
      child: BlocConsumer<EventDetailBloc, EventDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.isFinish == true) {
            return const EventDetailPageTest();
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
