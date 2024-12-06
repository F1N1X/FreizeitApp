// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class LoadingEvent extends EventEvent {}

class SuccededLoadingEvent extends EventEvent {}

class LoadingSubscripedEvent extends EventEvent {}

class EventUpdateEvent extends EventEvent {
  final Either<EventFailure, List<Event>> failedOrLoadedEvents;
  EventUpdateEvent({
    required this.failedOrLoadedEvents,
  });
}

class LoadingAllEvents extends EventEvent {
  final Either<EventFailure, List<Event>> failedOrLoadedEvent;
  LoadingAllEvents({
    required this.failedOrLoadedEvent,
  });
}

class LoadingEventSearch extends EventEvent {
  final String categorie;
  final DateTime time;
  LoadingEventSearch({required this.categorie, required this.time});
}

class UpdateEvents extends EventEvent {
  final Either<EventFailure, List<Event>> failedOrLoadedEvent;
  UpdateEvents({
    required this.failedOrLoadedEvent,
  });
}

class LoadingCityEvents extends EventEvent {}

class AllEvent extends EventEvent {
  final List<Event> eventList;
  AllEvent({
    required this.eventList,
  });
}

class StartLoadingEvent extends EventEvent {}

class CreateEvent extends EventEvent {
  final Event? event;
  CreateEvent({
    this.event,
  });
}

class AddEventToUser extends EventEvent {
  final UniqueID id;
  AddEventToUser({
    required this.id,
  });
}

class AddEventFinish extends EventEvent {
  final Either<EventFailure, Unit> eventAddFailOrSucced;
  AddEventFinish({
    required this.eventAddFailOrSucced,
  });
}
