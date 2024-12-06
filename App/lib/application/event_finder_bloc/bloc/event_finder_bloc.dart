import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/entities/id.dart';
import 'package:freizeit_app/repositories/event/eventrepository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart';

part 'event_finder_event.dart';
part 'event_finder_state.dart';

class EventFinderBloc extends Bloc<EventFinderEvent, EventFinderState> {
  final EventRepository eventRepository;

  EventFinderBloc({required this.eventRepository})
      : super(EventFinderInitial()) {
    on<StartFindingEvent>((event, emit) async {
      emit(LoadingEventFilterResults());
      Position userLocation = await _currentUserLocation();
      Map<String, Set<double>> filter = getData(
          LatLng(userLocation.latitude, userLocation.longitude), event.radius);
      //var radius = event.radius;
      //var categorie = event.categorie;
      //var time = event.time;
      List<Event> filteredEvents = List.empty(growable: true);
      List<Event> eventList = List.empty();
      final failOrSucces = await eventRepository.loadEventList();
      failOrSucces.fold((failed) => null, (events) => eventList = events);

      if (eventList.isNotEmpty) {
        for (int i = 0; i < eventList.length; i++) {
          if (filterEvent(eventList[i], filter)) {
            filteredEvents.add(eventList[i]);
          }
        }
      }

      emit(EventFinderFiltered(eventList: filteredEvents));
    });

    on<LoadingFoundedEvents>((event, emit) {
      emit(EventFinderFiltered(eventList: event.eventList));
    });

    on<AddTipedEventToUser>((event, emit) async {
      //Fehlerhandling
      await eventRepository.addEventToUser(event.id);
    });
  }

  bool filterEvent(Event event, Map<String, Set<double>> filter) {
    var latEvent = event.eventGeoPoint.latitude;
    var longEvent = event.eventGeoPoint.longitude;
    var userData = filter['center'] as Set<double>;
    var userLat = userData.first;
    var userLong = userData.last;

    var nwData = filter['nw'] as Set<double>;
    var nwLat = nwData.first;
    var nwLong = nwData.last;

    var noData = filter['no'] as Set<double>;
    var noLat = noData.first;
    var noLong = noData.last;

    var swData = filter['sw'] as Set<double>;
    var swLat = swData.first;
    var swLong = swData.last;

    var soData = filter['so'] as Set<double>;
    var soLat = soData.first;
    var soLong = soData.last;

    if ((latEvent < nwLat && latEvent > userLat) &&
        (longEvent > nwLong && longEvent < userLong)) {
      return true;
    }
    if ((latEvent < noLat && userLat < latEvent) &&
        (longEvent < noLong && userLong < longEvent)) {
      return true;
    }
    if ((latEvent > swLat && latEvent < longEvent) &&
        (longEvent > swLong && longEvent > userLong)) {
      return true;
    }
    if ((latEvent > soLat && latEvent < userLat) &&
        (longEvent < soLong && longEvent > userLong)) {
      return true;
    }
    return false;
  }

  Map<String, Set<double>> getData(LatLng centerLocation, double radius) {
    var latitute = centerLocation.latitude;
    var longitute = centerLocation.longitude;
    var earthRadius = 6371;
    var maxLat = latitute + degrees(radius / earthRadius);
    var minLat = latitute - degrees(radius / earthRadius);
    var maxLong =
        longitute + degrees(radius / earthRadius / cos(radians(latitute)));
    var minLong =
        longitute - degrees(radius / earthRadius / cos(radians(latitute)));

    Map<String, Set<double>> dataMap = {
      'center': {latitute, longitute},
      'nw': {maxLat, minLong},
      'no': {maxLat, maxLong},
      'sw': {minLat, minLong},
      'so': {minLat, maxLong}
    };

    return dataMap;
  }

  Future<Position> _currentUserLocation() async {
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
    return position;
  }
}
