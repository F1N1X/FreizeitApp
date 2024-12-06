// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_bloc.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventLoadingSucced extends EventState {
  final List<Event> events;
  final Position position;
  EventLoadingSucced({required this.events, required this.position});
}

class FindedEvents extends EventState {
  final List<Event> events;
  FindedEvents({required this.events});
}

class EventLoading extends EventState {}

class LoadingFailure extends EventState {
  final EventFailure failure;
  LoadingFailure({
    required this.failure,
  });
}

class AddEventSucced extends EventState {}

class AddEventFailed extends EventState {}

class AddEventLoad extends EventState {}

class AddEventLoadFinish extends EventState {}
