part of 'eventupdate_bloc.dart';

@immutable
abstract class EventupdateState {}

class EventInit implements EventupdateState {}

class EventupdateInitial extends EventupdateState {
  final Event event;

  EventupdateInitial({required this.event});
}

class EventUpdateFailed extends EventupdateState {
  final Event event;

  EventUpdateFailed({required this.event});
}

class EventUpdateSucced extends EventupdateState {
  final Event event;

  EventUpdateSucced({required this.event});
}

class EventInitialFinish extends EventupdateState {
  final Event event;

  EventInitialFinish({required this.event});
}
