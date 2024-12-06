part of 'eventupdate_bloc.dart';

@immutable
abstract class EventupdateEvent {}

class EventUpdateInitial implements EventupdateEvent {
  final Event event;

  EventUpdateInitial({required this.event});
}

class EventPageInitialized implements EventupdateEvent {
  final Event event;
  EventPageInitialized({required this.event});
}

class EventUpdateData implements EventupdateEvent {
  final Event? event;
  final String? name;
  final String? eventDescription;
  final dynamic eventCreationDate;
  final GeoPoint? eventGeoPoint;
  final String? eventType;
  final int? maxMember;
  final int? memberCount;
  final Timestamp? startDate;
  EventUpdateData({
    this.event,
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
