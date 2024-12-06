import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/application/auth_checker/bloc/auth_bloc.dart';
import 'package:freizeit_app/application/event_detail/bloc/event_detail_bloc.dart';
import 'package:freizeit_app/core/pictures_path.dart';
import 'package:freizeit_app/routes/router.gr.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'event_detail_textfield.dart';

class EventDetailPageTest extends StatefulWidget {
  const EventDetailPageTest({super.key});

  @override
  State<EventDetailPageTest> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPageTest> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int index = 0;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateUnAuthenticated) {
          AutoRouter.of(context).replace(const LoginPageRoute());
        }
      },
      child: BlocConsumer<EventDetailBloc, EventDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          final GetPathToPicture helper = GetPathToPicture();
          final LatLng geo = LatLng(state.event.eventGeoPoint.latitude,
              state.event.eventGeoPoint.longitude);
          return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  SizedBox(
                    height: height / 4,
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: geo, zoom: 14),
                      markers: {
                        Marker(markerId: const MarkerId("Event"), position: geo)
                      },
                    ),
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                      color: const Color.fromARGB(255, 10, 94, 239),
                      height: 100,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              helper.getPathToPicture(state.event.eventType),
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(state.event.name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontFamily: 'RobotoMono')),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    EventDetailTextField(
                      width: width,
                      firstText: 'Kategorie',
                      eventText: state.event.eventType,
                    ),
                    EventDetailTextField(
                      width: width,
                      firstText: 'Beschreibung',
                      eventText: state.event.eventDescription,
                    ),
                    EventDetailTextField(
                      width: width,
                      firstText: 'Startdatum',
                      eventText: helper.transformDateToString(
                          state.event.startDate as Timestamp),
                    ),
                    EventDetailTextField(
                      width: width,
                      firstText: 'Nutzer',
                      eventText:
                          "${state.event.memberCount}/${state.event.maxMember}",
                    )
                  ]),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  if (index == 3 && state.isAdmin == false) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("du hast keine Berechtigung")));
                  }

                  onTap(
                      index, state.event.id.value, state.isAdmin, state.event);
                },
                currentIndex: index,
                backgroundColor: Colors.white,
                //selectedFontSize: , unselectedFontSize
                iconSize: 20,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_back),
                      label: 'Zurück',
                      backgroundColor: Colors.blue),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.navigation_outlined),
                    backgroundColor: Colors.blue,
                    label: 'Navigation',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.message_sharp),
                      label: 'Eventnachrichten',
                      backgroundColor: Colors.blue),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.edit),
                      label: 'Navigation',
                      backgroundColor: Colors.blue),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.delete),
                      label: 'Navigation',
                      backgroundColor: Colors.blue),
                ],
              ));
        },
      ),
    );
  }

  void onTap(int index, String id, bool isAdmin, Event event) {
    if (index == 0) {
      AutoRouter.of(context).replace(const PersonalEventPageRoute());
    } else if (index == 1) {
    } else if (index == 2) {
      AutoRouter.of(context).replace(EventMessagesPageRoute(id: id));
    } else if (index == 3 && isAdmin) {
      AutoRouter.of(context).replace(InitialEventUpdateRoute(event: event));
    } else if (index == 5) {
      //DELETE
    }
  }
}
