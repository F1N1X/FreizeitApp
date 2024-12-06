// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:freizeit_app/entities/id.dart';

class Event {
  final String name;
  final UniqueID id;
  final String eventDescription;
  final List<dynamic>? eventMessages;
  final dynamic eventCreationDate;
  final GeoPoint eventGeoPoint;
  final String eventType;
  final int maxMember;
  final int? memberCount;
  final dynamic startDate;
  final String adminid;
  final List<dynamic> users;

  Event({
    required this.users,
    required this.adminid,
    required this.name,
    required this.id,
    required this.eventDescription,
    required this.eventMessages,
    required this.eventCreationDate,
    required this.eventGeoPoint,
    required this.eventType,
    required this.maxMember,
    required this.memberCount,
    required this.startDate,
  });

  factory Event.empty() {
    return Event(
        users: List.empty(),
        adminid: "",
        name: "",
        id: UniqueID(),
        eventDescription: "",
        eventMessages: null,
        eventCreationDate: null,
        eventGeoPoint: const GeoPoint(10.0, 20),
        eventType: "",
        maxMember: 0,
        memberCount: 0,
        startDate: null);
  }

  Event copyWith({
    String? name,
    UniqueID? id,
    String? eventDescription,
    List<dynamic>? eventMessages,
    dynamic eventCreationDate,
    GeoPoint? eventGeoPoint,
    String? eventType,
    int? maxMember,
    int? memberCount,
    dynamic startDate,
    String? adminid,
    List<dynamic>? users,
  }) {
    return Event(
      name: name ?? this.name,
      id: id ?? this.id,
      eventDescription: eventDescription ?? this.eventDescription,
      eventMessages: eventMessages ?? this.eventMessages,
      eventCreationDate: eventCreationDate ?? this.eventCreationDate,
      eventGeoPoint: eventGeoPoint ?? this.eventGeoPoint,
      eventType: eventType ?? this.eventType,
      maxMember: maxMember ?? this.maxMember,
      memberCount: memberCount ?? this.memberCount,
      startDate: startDate ?? this.startDate,
      adminid: adminid ?? this.adminid,
      users: users ?? this.users,
    );
  }
}
