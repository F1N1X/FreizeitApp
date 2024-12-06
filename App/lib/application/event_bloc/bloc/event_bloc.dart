import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freizeit_app/Failures/event_failure.dart';
import 'package:freizeit_app/entities/id.dart';
import 'package:freizeit_app/repositories/event/eventrepository.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:freizeit_app/Model/event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;
  StreamSubscription<Either<EventFailure, List<Event>>>?
      _eventStreamSubscription;

  StreamSubscription<Either<EventFailure, List<Event>>>? _allEventStream;

  EventBloc({required this.eventRepository}) : super(EventInitial()) {
    on<LoadingSubscripedEvent>((event, emit) async {
      emit(EventLoading());
      await _eventStreamSubscription?.cancel();
      _eventStreamSubscription =
          eventRepository.watchAllSubscriped().listen((eventOrFailed) {
        add(EventUpdateEvent(failedOrLoadedEvents: eventOrFailed));
      });
    });

    //State änderung zum neu rendern
    on<StartLoadingEvent>((event, emit) async {
      //Option müssen gefoldet werden und reaction auf none/some die klammern
      add(LoadingCityEvents());
    });

    on<EventUpdateEvent>(
      (event, emit) async {
        final position = await _currentUserLocation();
        event.failedOrLoadedEvents.fold(
            (failure) => emit(LoadingFailure(failure: failure)),
            (events) =>
                emit(EventLoadingSucced(events: events, position: position)));
      },
    );

    on<LoadingCityEvents>(((event, emit) async {
      emit(EventLoading());
      await _allEventStream?.cancel();
      _allEventStream = eventRepository.loadAllEvents().listen((event) {
        add(EventUpdateEvent(failedOrLoadedEvents: event));
      });
    }));

    on<LoadingEventSearch>(((event, emit) async {
      emit(EventLoading());
      List<Event> eventList = List.empty();
      await _allEventStream?.cancel();
      _allEventStream = eventRepository.loadAllEvents().listen((event) {
        event.fold((l) => null, (r) => {eventList = r});
      });
      for (int i = 0; i < eventList.length; i++) {
        if (eventList[i].eventType == event.categorie &&
            eventList[i].startDate as DateTime == event.time) {
        } else {
          eventList.remove(eventList[i]);
        }
      }
      emit(FindedEvents(events: eventList));
    }));

    on<UpdateEvents>(((event, emit) async {
      final position = await _currentUserLocation();
      event.failedOrLoadedEvent.fold(
          (failure) => emit(LoadingFailure(failure: failure)),
          (events) =>
              emit(EventLoadingSucced(events: events, position: position)));
    }));

    on<AddEventToUser>(((event, emit) async {
      emit(EventInitial());
      final failOrSucced = await eventRepository.addEventToUser(event.id);
      add(AddEventFinish(eventAddFailOrSucced: failOrSucced));
    }));

    on<AddEventFinish>(((event, emit) {
      event.eventAddFailOrSucced.fold((failure) => emit(AddEventFailed()),
          (success) {
        add(LoadingCityEvents());
      });
    }));
  }

  @override
  Future<void> close() async {
    await _eventStreamSubscription?.cancel();
    return super.close();
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
