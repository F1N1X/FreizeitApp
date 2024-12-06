import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/event_form_bloc/bloc/event_form_bloc.dart';
import 'package:freizeit_app/application/user_information/bloc/userinformation_bloc.dart';
import 'package:freizeit_app/praesentation/event_detail/event_detail_button.dart';
import 'package:freizeit_app/praesentation/eventcreation/kategorie_elements.dart';
import 'package:freizeit_app/routes/router.gr.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventCreationWithMap extends StatefulWidget {
  const EventCreationWithMap({super.key});

  @override
  State<EventCreationWithMap> createState() => _EventCreationWithMapState();
}

class _EventCreationWithMapState extends State<EventCreationWithMap> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController memberController = TextEditingController();
  CustomInfoWindowController custumController = CustomInfoWindowController();
  TextEditingController textEditingControllerEventDate =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    memberController.dispose();
    custumController.dispose();
    textEditingControllerEventDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    late LatLng eventLocation;
    late DateTime startDate;

    return BlocBuilder<UserinformationBloc, UserInformationState>(
      builder: (context, state) {
        if (state is LoadedUserGeoData) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 5,
                        width: size.width,
                        child: Image.asset(
                          'lib/images/startlogo.png',
                        ),
                      ),
                      const Text(
                        "Erstelle dein Event",
                        style: TextStyle(
                            letterSpacing: 3,
                            color: Color.fromARGB(255, 126, 126, 126),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            fontSize: 30),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              height: 10,
                              width: MediaQuery.of(context).size.width,
                              decoration:
                                  const BoxDecoration(color: Colors.blue),
                            ),
                          ),
                          Form(
                              child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextFormField(
                                  controller: nameController,
                                  obscureText: false,
                                  // validator: validateEmail,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
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
                                      labelText:
                                          "Gib deinem Event einen Namen"),
                                  cursorColor: Colors.white,
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
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
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
                                      labelText: "Beschreibe dein Event"),
                                  cursorColor: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: TextFormField(
                                  controller: memberController,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  // validator: validateEmail,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
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
                                      labelText: "Wie viele Mitglieder?"),
                                  cursorColor: Colors.white,
                                ),
                              ),
                              const Padding(
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
                              const CategoriePageView(),
                              const Text(
                                "Startdatum",
                                style: TextStyle(
                                    letterSpacing: 3,
                                    color: Color.fromARGB(255, 126, 126, 126),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    fontSize: 20),
                              ),
                              TextField(
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
                                    labelText: "Datum"),
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
                                    startDate = eventData;
                                  }
                                },
                              ),
                              const SizedBox(
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
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 500,
                                      width: MediaQuery.of(context).size.width,
                                      child: GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                                state.geodata.latitude,
                                                state.geodata.longitude),
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
                                                                eventLocation =
                                                                    position;
                                                                custumController
                                                                    .hideInfoWindow!();
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: InkResponse(
                                                              child: const Icon(
                                                                  Icons
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
                          const SizedBox(
                            height: 10,
                          ),
                          InkResponse(
                            child: const EventDetailButton(
                              background: Colors.blue,
                              hight: 50,
                              width: 100,
                              text: 'Erstelle dein Event',
                              textColor: Colors.white,
                              borderColor: Colors.grey,
                              icon: Icons.check,
                              isIcon: true,
                            ),
                            onTap: () {
                              BlocProvider.of<EventFormBloc>(context).add(
                                  CreatePressedEvent(
                                      name: nameController.value.text,
                                      eventDescription:
                                          nameController.value.text,
                                      eventType: "Test",
                                      maxMember: int.parse(
                                          memberController.value.text),
                                      eventGeoPoint: GeoPoint(
                                          eventLocation.latitude,
                                          eventLocation.longitude),
                                      startDate:
                                          Timestamp.fromDate(startDate)));

                              AutoRouter.of(context)
                                  .replace(const WelcomePageRoute());
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
