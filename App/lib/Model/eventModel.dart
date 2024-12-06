// ignore: file_names
// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/entities/id.dart';

class EventModel {
  final String name;
  final String id;
  final String eventDescription;
  final List<dynamic>? eventMessages;
  final dynamic eventCreationDate;
  final GeoPoint eventGeoPoint;
  final String eventType;
  final int maxMember;
  final int memberCount;
  final Timestamp? startDate;
  final String adminid;
  final List<dynamic> users;

  EventModel({
    required this.adminid,
    required this.users,
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

  Map<String, dynamic> toMap() {
    return {
      'admin': adminid,
      'id': id,
      'name': name,
      'eventDescription': eventDescription,
      'eventMessages': eventMessages,
      'eventCreationDate': eventCreationDate,
      'geoData': eventGeoPoint,
      'groupType': eventType,
      'maxMember': maxMember,
      'memberCount': memberCount,
      'startDate': startDate,
      'users': users
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      users: map['users'] as List<dynamic>,
      adminid: map['admin'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      eventCreationDate: map['eventCreationDate'] as dynamic,
      eventDescription: map['eventDescription'] as String,
      eventGeoPoint: map['geoData'] as GeoPoint,
      eventMessages: map['eventMessages'] as List<dynamic>,
      eventType: map['groupType'] as String,
      maxMember: map['maxMember'] as int,
      memberCount: map['memberCount'] as int,
      startDate: map['startDate'] as dynamic,
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        users: json['users'] as List<dynamic>,
        adminid: json['admin'] as String,
        id: json['id'] as String,
        name: json['name'] as String,
        eventCreationDate: json['eventCreationDate'] as dynamic,
        eventDescription: json['eventDescription'] as String,
        eventGeoPoint: json['geoData'] as GeoPoint,
        eventMessages: json['eventMessages'] as List<dynamic>,
        eventType: json['groupType'] as String,
        maxMember: json['maxMember'] as int,
        memberCount: json['memberCount'] as int,
        startDate: json['startDate'] as dynamic,
      );
  //ID extra
  factory EventModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return EventModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  //Timestempextra

//Mappen in Entity
  Event toDomain() {
    return Event(
        users: users,
        adminid: adminid,
        name: name,
        id: UniqueID.fromUniqueString(id),
        eventCreationDate: eventCreationDate,
        eventDescription: eventDescription,
        eventGeoPoint: eventGeoPoint,
        eventMessages: eventMessages!.toList(),
        eventType: eventType,
        maxMember: maxMember,
        memberCount: memberCount,
        startDate: startDate);
  }

  //Timestemp
  factory EventModel.fromDomain(Event eventItem) {
    return EventModel(
      users: List<dynamic>.empty(),
      adminid: eventItem.adminid,
      name: eventItem.name,
      id: eventItem.id.value,
      eventDescription: eventItem.eventDescription,
      eventMessages: List<dynamic>.empty(),
      eventCreationDate: FieldValue.serverTimestamp(),
      eventGeoPoint: eventItem.eventGeoPoint,
      eventType: eventItem.eventType,
      maxMember: eventItem.maxMember,
      memberCount: 1,
      startDate: eventItem.startDate,
    );
  }

  EventModel copyWith({
    String? name,
    String? id,
    String? eventDescription,
    List<dynamic>? eventMessages,
    dynamic eventCreationDate,
    GeoPoint? eventGeoPoint,
    String? eventType,
    int? maxMember,
    int? memberCount,
    Timestamp? startDate,
    String? adminid,
    List<dynamic>? users,
  }) {
    return EventModel(
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
