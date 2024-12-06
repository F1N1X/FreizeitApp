import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/application/event_form_bloc/bloc/event_form_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/eventcreation/event_creation_form.dart';
import 'package:freizeit_app/praesentation/login/widgets/custom_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventCreationPage extends StatelessWidget {
  final Event? event;
  final LatLng position;
  const EventCreationPage(
      {super.key, required this.event, required this.position});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<EventFormBloc>()
        ..add(InitialzeCreationForm(event: event)),
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: EventForm(position: position),
        bottomNavigationBar: CustomButton(
            buttonText: "Zurück",
            callback: () {
              //AutoRouter.of(context).replace(const WelcomePageRoute());
            }),
      ),
    );
  }
}
