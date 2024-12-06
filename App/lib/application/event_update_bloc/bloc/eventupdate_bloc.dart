import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freizeit_app/repositories/event/eventrepository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../Model/event.dart';

part 'eventupdate_event.dart';
part 'eventupdate_state.dart';

class EventupdateBloc extends Bloc<EventupdateEvent, EventupdateState> {
  final EventRepository eventRepository;

  EventupdateBloc({required this.eventRepository}) : super(EventInit()) {
    on<EventUpdateInitial>((event, emit) {
      emit(EventupdateInitial(event: event.event));
    });

    on<EventUpdateData>((event, emit) async {
      final Event oldEvent = event.event!;
      final Event updateEvent = event.event!.copyWith(
          eventDescription: event.eventDescription,
          eventGeoPoint: event.eventGeoPoint,
          memberCount: event.memberCount,
          startDate: event.startDate,
          name: event.name);

      final failedOrSucced = await eventRepository.update(updateEvent);

      failedOrSucced.fold((l) => emit(EventUpdateFailed(event: oldEvent)),
          (r) => emit(EventUpdateSucced(event: updateEvent)));
    });
    on<EventPageInitialized>((event, emit) {
      emit(EventInitialFinish(event: event.event));
    });
  }
}
