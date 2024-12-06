part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class LoadEventForMessage extends MessageEvent {
  final String id;

  LoadEventForMessage({required this.id});
}

class UpdateEventWithMessage extends MessageEvent {
  final String message;
  final String id;

  UpdateEventWithMessage({required this.message, required this.id});
}

class FinishLoadingEvent extends MessageEvent {
  final Either<EventFailure, Event> failedOrLoadedEvents;

  FinishLoadingEvent({required this.failedOrLoadedEvents});
}
