import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/application/event_update_bloc/bloc/eventupdate_bloc.dart';
import 'package:freizeit_app/core/pictures_path.dart';
import 'package:freizeit_app/routes/router.gr.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UpdateEventForm extends StatefulWidget {
  const UpdateEventForm({super.key});

  @override
  State<UpdateEventForm> createState() => _UpdateEventFormState();
}

class _UpdateEventFormState extends State<UpdateEventForm> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController memberController = TextEditingController();
  CustomInfoWindowController custumController = CustomInfoWindowController();
  TextEditingController textEditingControllerEventDate =
      TextEditingController();
  TextEditingController nameController = TextEditingController();

  GetPathToPicture helper = GetPathToPicture();
  late String name;
  late String description;
  late String maxMember;
  late LatLng eventLocation;
  late DateTime startDate;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    memberController.dispose();
    custumController.dispose();
    textEditingControllerEventDate.dispose();
    super.dispose();
  }

  void changeName(String value) {
    setState(() {
      name = value;
    });
  }

  void changeDescription(String value) {
    setState(() {
      description = value;
    });
  }

  void changeMember(String value) {
    setState(() {
      maxMember = value;
    });
  }

  void changeDate(DateTime value) {
    setState(() {
      startDate = value;
    });
  }

  void changeLocation(LatLng value) {
    setState(() {
      eventLocation = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Marker> markers = <Marker>[];
    int index = 0;

    return BlocConsumer<EventupdateBloc, EventupdateState>(
      listener: (context, state) {
        if (state is EventUpdateSucced) {
          AutoRouter.of(context).replace(EventDetailRoute(event: state.event));
        }

        if (state is EventUpdateFailed) {}
      },
      builder: (context, state) {
        if (state is EventupdateInitial) {
          name = state.event.name;
          eventLocation = LatLng(state.event.eventGeoPoint.latitude,
              state.event.eventGeoPoint.longitude);
          description = state.event.eventDescription;
          maxMember = state.event.maxMember.toString();
          startDate =
              helper.timeStampToDayTime(state.event.startDate as Timestamp);
          markers.add(
            Marker(
                markerId: const MarkerId('location'),
                position: LatLng(state.event.eventGeoPoint.latitude,
                    state.event.eventGeoPoint.longitude)),
          );
          BlocProvider.of<EventupdateBloc>(context)
              .add(EventPageInitialized(event: state.event));

          //TYP NOCH ÄNDERN VON DYNAMIC

        } else if (state is EventInitialFinish) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 5,
                      width: size.width,
                      child: Image.asset(
                        'lib/images/startlogo.png',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Update deine Eventdaten",
                        style: TextStyle(
                            letterSpacing: 3,
                            color: Color.fromARGB(255, 126, 126, 126),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            fontSize: 20),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 10,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(color: Colors.blue),
                          ),
                        ),
                        Form(
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                controller: nameController,
                                obscureText: false,
                                // validator: validateEmail,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    iconColor: Colors.grey,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    filled: true,
                                    prefixIcon: const Icon(Icons.abc),
                                    labelText: state.event.name),
                                cursorColor: Colors.white,
                                onChanged: (value) => changeName(value),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TextFormField(
                                controller: descriptionController,
                                obscureText: false,
                                // validator: validateEmail,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    iconColor: Colors.grey,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    filled: true,
                                    prefixIcon: const Icon(Icons.description),
                                    labelText: description),
                                cursorColor: Colors.white,
                                onChanged: (value) => changeDescription(value),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: TextFormField(
                                controller: memberController,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                // validator: validateEmail,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    iconColor: Colors.grey,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    filled: true,
                                    prefixIcon: const Icon(
                                        Icons.format_list_numbered_rounded),
                                    labelText: maxMember),
                                cursorColor: Colors.white,
                                onChanged: (value) => changeMember(value),
                              ),
                            ),
                            /* const Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                "Kategorie",
                                style: TextStyle(
                                    letterSpacing: 3,
                                    color: Color.fromARGB(255, 126, 126, 126),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    fontSize: 20),
                              ),
                            ),
                            const UpdateCategorieList(),*/
                            /*const Text(
                              "Startdatum",
                              style: TextStyle(
                                  letterSpacing: 3,
                                  color: Color.fromARGB(255, 126, 126, 126),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  fontSize: 20),
                            ),*/
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TextField(
                                keyboardType: TextInputType.none,
                                controller: textEditingControllerEventDate,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    iconColor: Colors.grey,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    filled: true,
                                    prefixIcon: const Icon(Icons.date_range),
                                    labelText: helper
                                        .transformDateTimeToString(startDate)),
                                onTap: () async {
                                  DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2050));
                                  TimeOfDay? time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());

                                  if (date != null && time != null) {
                                    DateTime eventData = DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        time.hour,
                                        time.minute);
                                    changeDate(eventData);
                                  }
                                },
                              ),
                            ),
                            /*const SizedBox(
                              height: 70,
                            ),
                            const Text(
                              "Wähle deinen Standort",
                              style: TextStyle(
                                  letterSpacing: 3,
                                  color: Color.fromARGB(255, 126, 126, 126),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  fontSize: 20),
                            ),*/
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 500,
                                    width: MediaQuery.of(context).size.width,
                                    child: GoogleMap(
                                      markers: Set<Marker>.of(markers),
                                      initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              state
                                                  .event.eventGeoPoint.latitude,
                                              state.event.eventGeoPoint
                                                  .longitude),
                                          zoom: 14),
                                      zoomControlsEnabled: false,
                                      mapType: MapType.normal,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        custumController.googleMapController =
                                            controller;
                                      },
                                      onTap: (argument) {
                                        custumController.hideInfoWindow!();
                                      },
                                      onCameraMove: (position) {
                                        custumController.onCameraMove!();
                                      },
                                      onLongPress: (position) {
                                        custumController.addInfoWindow!(
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  const Text(
                                                    "Standort",
                                                    style: TextStyle(
                                                      letterSpacing: 5,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: InkResponse(
                                                            child: const Icon(
                                                                Icons
                                                                    .check_box),
                                                            onTap: () {
                                                              changeLocation(
                                                                  position);

                                                              custumController
                                                                  .hideInfoWindow!();
                                                            },
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: InkResponse(
                                                            child: const Icon(Icons
                                                                .indeterminate_check_box),
                                                            onTap: () {
                                                              custumController
                                                                  .hideInfoWindow!();
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            LatLng(position.latitude,
                                                position.longitude));
                                      },
                                    ),
                                  ),
                                  CustomInfoWindow(
                                    height: 100,
                                    width: 100,
                                    controller: custumController,
                                    offset: 35,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              iconSize: 20,
              backgroundColor: Colors.blue,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              onTap: (value) => onTap(value, state.event, name, description,
                  maxMember, startDate, eventLocation),
              items: const [
                BottomNavigationBarItem(
                  label: "Zurück",
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                  label: "Update",
                  icon: Icon(
                    Icons.update,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }

  void onTap(int index, Event event, String name, String description,
      String member, DateTime startDate, LatLng eventLocation) {
    if (index == 0) {
      AutoRouter.of(context).replace(EventDetailRoute(event: event));
    } else if (index == 1) {
      Timestamp timestamp = Timestamp.fromDate(startDate);
      int maxMember = int.parse(member);
      BlocProvider.of<EventupdateBloc>(context).add(EventUpdateData(
        eventGeoPoint:
            GeoPoint(eventLocation.latitude, eventLocation.longitude),
        event: event,
        startDate: timestamp,
        eventDescription: description,
        maxMember: maxMember,
        name: name,
      ));
    }
  }
}
