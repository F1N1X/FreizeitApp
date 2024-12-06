import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/routes/router.gr.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../../Model/event.dart';
import '../../application/event_bloc/bloc/event_bloc.dart';
import '../../core/pictures_path.dart';

class CurrentUserLocation extends StatefulWidget {
  final List<Event> events;
  final Position position;

  const CurrentUserLocation(
      {super.key, required this.events, required this.position});

  @override
  State<CurrentUserLocation> createState() => _CurrentUserLocationState();
}

class _CurrentUserLocationState extends State<CurrentUserLocation> {
  CustomInfoWindowController custumController = CustomInfoWindowController();
  late List<Event> eventList;
  late CameraPosition initialCamera;

  Set<Marker> markers = {};

  Uint8List? markerImage;

  final List<Marker> _markers = <Marker>[];

  List<String> images = [
    'lib/images/soccer-ball.png',
    'lib/images/soccer-ball.png'
  ];

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    eventList = widget.events;
    initialCamera = CameraPosition(
        target: LatLng(widget.position.latitude, widget.position.longitude),
        zoom: 14);
    loadData();
  }

  loadData() async {
    GetPathToPicture helper = GetPathToPicture();

    for (int i = 0; i < eventList.length; i++) {
      final path = helper.getPathToPicture(eventList[i].eventType);
      final Uint8List markerIcon = await getBytesFromAsset(path, 100);

      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(eventList[i].eventGeoPoint.latitude,
            eventList[i].eventGeoPoint.longitude),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        onTap: () {
          custumController.addInfoWindow!(
              Container(
                height: 130,
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
                                  letterSpacing: 2,
                                  fontFamily: 'RobotoMono',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              eventList[i].eventDescription,
                              style: const TextStyle(
                                  letterSpacing: 2,
                                  fontFamily: 'RobotoMono',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              eventList[i].eventType,
                              style: const TextStyle(
                                  letterSpacing: 2,
                                  fontFamily: 'RobotoMono',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${eventList[i].memberCount}/${eventList[i].maxMember}",
                              style: const TextStyle(
                                  letterSpacing: 2,
                                  fontFamily: 'RobotoMono',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              helper.transformDateToString(
                                  eventList[i].startDate as Timestamp),
                              style: const TextStyle(
                                  letterSpacing: 2,
                                  fontFamily: 'RobotoMono',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<EventBloc>(context)
                              .add(AddEventToUser(id: eventList[i].id));
                        },
                        icon: const Icon(
                          Icons.add_box_outlined,
                          size: 30,
                        ))
                  ],
                ),
              ),
              LatLng(eventList[i].eventGeoPoint.latitude,
                  eventList[i].eventGeoPoint.longitude));
        },
      ));
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is EventLoadingSucced) {
          return Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          state.position.latitude, state.position.longitude),
                      zoom: 14),
                  markers: Set<Marker>.of(_markers),
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
                                  style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 2,
                                    fontFamily: 'RobotoMono',
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: InkResponse(
                                            child: const Icon(
                                              Icons.check_box,
                                              size: 20,
                                            ),
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
                  height: 100,
                  width: 200,
                  offset: 35,
                )
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
