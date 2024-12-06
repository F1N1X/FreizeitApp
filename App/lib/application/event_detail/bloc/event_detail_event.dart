part of 'event_detail_bloc.dart';

@immutable
abstract class EventDetailEvent {}

class InitializeEventDetailPage extends EventDetailEvent {
  final Event? event;

  InitializeEventDetailPage(this.event);
}

class SendMessagePressed extends EventDetailEvent {
  final String? message;

  SendMessagePressed(this.message);
}

class SaveChangesPressedEvent extends EventDetailEvent {
  final String? title;
  final String? description;

  SaveChangesPressedEvent(this.title, this.description);
}
