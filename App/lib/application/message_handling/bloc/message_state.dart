part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}

class EventForMessageLoading {}

class LoadingEvent extends MessageEvent {}

class EventForMessageLodingSucceded extends MessageState {
  final Event event;

  EventForMessageLodingSucceded({required this.event});
}

class EventForMessageLoadingFailed extends MessageState {
  final EventFailure failure;

  EventForMessageLoadingFailed(this.failure);
}
