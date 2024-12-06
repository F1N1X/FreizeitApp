part of 'event_finder_bloc.dart';

@immutable
abstract class EventFinderEvent {}

class StartFindingEvent implements EventFinderEvent {
  final String categorie;
  final DateTime time;
  final double radius;

  StartFindingEvent(
      {required this.categorie, required this.time, required this.radius});
}

class LoadingFoundedEvents extends EventFinderEvent {
  final List<Event> eventList;

  LoadingFoundedEvents({required this.eventList});
}

class AddTipedEventToUser extends EventFinderEvent {
  final UniqueID id;

  AddTipedEventToUser({required this.id});
}
