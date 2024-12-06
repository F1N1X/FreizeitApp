// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_form_bloc.dart';

@immutable
abstract class EventFormEvent {}

class InitialzeCreationForm extends EventFormEvent {
  final Event? event;
  InitialzeCreationForm({
    this.event,
  });
}

class CreatePressedEvent extends EventFormEvent {
  final String? name;
  final String? eventDescription;
  final dynamic eventCreationDate;
  final GeoPoint? eventGeoPoint;
  final String? eventType;
  final int? maxMember;
  final int? memberCount;
  final Timestamp? startDate;
  CreatePressedEvent({
    this.name,
    this.eventDescription,
    this.eventCreationDate,
    this.eventGeoPoint,
    this.eventType,
    this.maxMember,
    this.memberCount,
    this.startDate,
  });
}

class UpdatePressed extends EventFormEvent {
  final String? name;
  final String? eventDescription;
  final dynamic eventCreationDate;
  final GeoPoint? eventGeoPoint;
  final String? eventType;
  final int? maxMember;
  final int? memberCount;
  final Timestamp? startDate;
  UpdatePressed({
    this.name,
    this.eventDescription,
    this.eventCreationDate,
    this.eventGeoPoint,
    this.eventType,
    this.maxMember,
    this.memberCount,
    this.startDate,
  });
}
