import 'package:auto_route/auto_route.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/application/event_bloc/bloc/event_bloc.dart';

import 'package:freizeit_app/routes/router.gr.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventMap extends StatefulWidget {
  const EventMap({super.key});

  @override
  State<EventMap> createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  late List<Event> eventList;
  late CameraPosition initialCamera;
  List<Marker> markers = <Marker>[];
  late Marker userMarker;
  List<String> images = [
    'lib/images/soccer-ball.png',
    'lib/images/soccer-ball.png'
  ];

  Uint8List? markerImage;
  CustomInfoWindowController custumController = CustomInfoWindowController();

  loadElements() async {
    await loadData();
    await _currentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is EventLoadingSucced) {
          eventList = state.events;
          loadElements();
        }

        if (state is EventLoadingSucced) {
          eventList = state.events;

          return Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: initialCamera,
                  markers: Set<Marker>.of(markers),
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    custumController.googleMapController = controller;
                  },
                  onTap: (position) {
                    custumController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    custumController.onCameraMove!();
                  },
                  onLongPress: (position) {
                    custumController.addInfoWindow!(
                        Center(
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 253, 253, 253),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Event anlegen?",
                                  style:
                                      TextStyle(letterSpacing: 5, fontSize: 18),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: InkResponse(
                                            child: const Icon(Icons.check_box),
                                            onTap: () {
                                              AutoRouter.of(context).replace(
                                                  EventCreationPageRoute(
                                                      event: null,
                                                      position: position));
                                            },
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: InkResponse(
                                            child: const Icon(
                                                Icons.cancel_outlined),
                                            onTap: () {
                                              custumController
                                                  .hideInfoWindow!();
                                            },
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            )),
                          ),
                        ),
                        LatLng(position.latitude, position.longitude));
                  },
                ),
                CustomInfoWindow(
                  controller: custumController,
                  height: 70,
                  width: 200,
                  offset: 35,
                )
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _currentUserLocation();
                });
              },
              label: const Text("Current Location"),
              icon: const Icon(Icons.check),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> loadData() async {
    for (int i = 0; i < eventList.length; i++) {
      final Uint8List markerIcon = await getBytesFromAsset(images[0], 100);

      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(eventList[i].eventGeoPoint.latitude,
            eventList[i].eventGeoPoint.longitude),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        onTap: () {
          custumController.addInfoWindow!(
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              eventList[i].name,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              eventList[i].eventDescription,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              eventList[i].eventType,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${eventList[i].memberCount}/${eventList[i].maxMember}",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: IconButton(
                              onPressed: () {
                                BlocProvider.of<EventBloc>(context)
                                    .add(AddEventToUser(id: eventList[i].id));
                              },
                              icon: const Icon(
                                Icons.add_alarm_rounded,
                                size: 30,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              LatLng(eventList[i].eventGeoPoint.latitude,
                  eventList[i].eventGeoPoint.longitude));
        },
      ));
    }
  }

  Future<void> _currentUserLocation() async {
    bool gpsIsEnable;
    LocationPermission permission;

    gpsIsEnable = await Geolocator.isLocationServiceEnabled();

    if (!gpsIsEnable) {
      return Future.error('Location service is disable');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission dinied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Go to Setting and change Permissions');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    initialCamera =
        CameraPosition(target: LatLng(position.latitude, position.longitude));
    userMarker = Marker(
        markerId: const MarkerId("userLocation"),
        position: LatLng(position.latitude, position.longitude));
  }
}
