import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/event_form_bloc/bloc/event_form_bloc.dart';
import 'package:freizeit_app/praesentation/login/widgets/custom_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/router.gr.dart';

class EventForm extends StatelessWidget {
  final LatLng position;

  const EventForm({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final textEditingControllerName = TextEditingController();
    final textEditingControllerDescription = TextEditingController();
    final textEditingControllerMember = TextEditingController();
    final textEditingControllerEventType = TextEditingController();
    final textEditingControllerEventDate = TextEditingController();

    late String eventName;
    late String description;
    //late int maxMember;
    late String stringMember;
    late String eventType;
    //late GeoPoint geoPoint;
    late DateTime startDate;

    String? validateName(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter description";
      } else if (input.length < 30) {
        eventName = input;
        return null;
      } else {
        return "body to long";
      }
    }

    String? validateDescription(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter description";
      } else if (input.length < 30) {
        description = input;
        return null;
      } else {
        return "body to long";
      }
    }

    String? validateTyp(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter description";
      } else if (input.length < 30) {
        eventType = input;
        return null;
      } else {
        return "body to long";
      }
    }

    String? validateMember(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter description";
      } else {
        stringMember = input;
      }
      return 'Keine Zahl';
    }

    return BlocConsumer<EventFormBloc, CreationFormState>(
      //ListenWhen
      listener: (context, state) {
        textEditingControllerName.text = state.event.name;
        textEditingControllerDescription.text = state.event.eventDescription;
        textEditingControllerMember.text = state.event.maxMember.toString();
        textEditingControllerEventType.text = state.event.eventType;
      },
      builder: (context, state) {
        return Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formKey,
              child: ListView(
                children: [
                  TextFormField(
                    //!Einbinden von Controller
                    controller: textEditingControllerName,
                    validator: validateName,
                    //Eigenschaften des Feldes
                    maxLength: 100,
                    maxLines: 2,
                    minLines: 1,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        labelText: "Eventname",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //!Einbinden des Controllers
                    controller: textEditingControllerDescription,
                    validator: validateDescription,
                    //Eigenschaften des Feldes
                    maxLength: 300,
                    maxLines: 8,
                    minLines: 5,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        labelText: "Eventbeschreibung",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //!Einbinden des Controllers
                    controller: textEditingControllerEventType,
                    validator: validateTyp,
                    //Eigenschaften des Feldes
                    maxLength: 300,
                    maxLines: 8,
                    minLines: 5,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        labelText: "Eventtyp",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    //!Einbinden des Controllers
                    controller: textEditingControllerMember,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: validateMember,
                    //Eigenschaften des Feldes
                    maxLength: 300,
                    maxLines: 8,
                    minLines: 5,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        labelText: "Anzahl der Leute",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: textEditingControllerEventDate,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_month_outlined),
                        labelText: "Startdatum"),
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050));
                      TimeOfDay? time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());

                      if (date != null && time != null) {
                        DateTime eventData = DateTime(date.year, date.month,
                            date.day, time.hour, time.minute);
                        startDate = eventData;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  CustomButton(
                      buttonText: "Event erstellen",
                      callback: () {
                        BlocProvider.of<EventFormBloc>(context).add(
                            CreatePressedEvent(
                                name: eventName,
                                eventDescription: description,
                                eventType: eventType,
                                maxMember: int.parse(stringMember),
                                eventGeoPoint: GeoPoint(
                                    position.latitude, position.longitude),
                                startDate: Timestamp.fromDate(startDate)));

                        AutoRouter.of(context).replace(const CityPageRoute());
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
