part of 'event_finder_bloc.dart';

@immutable
abstract class EventFinderState {}

class EventFinderInitial extends EventFinderState {}

class LoadingEventFilterResults extends EventFinderState {}

class EventFinderFiltered extends EventFinderState {
  final List<Event> eventList;

  EventFinderFiltered({required this.eventList});
}
