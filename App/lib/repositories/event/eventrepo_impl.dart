// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:freizeit_app/Failures/event_failure.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/Model/eventModel.dart';
import 'package:freizeit_app/entities/id.dart';
import 'package:freizeit_app/repositories/event/eventrepository.dart';
import 'package:freizeit_app/repositories/event/firebase_helper/FirestoreExtion.dart';

class EventRepositoryImp extends EventRepository {
  final FirebaseFirestore firebase;
  EventRepositoryImp({
    required this.firebase,
  });

  @override
  Future<Either<EventFailure, Unit>> create(Event event) async {
    try {
      final userDocument = await firebase.userDocument();
      final eventDocument = await firebase.eventDocTest();
      final eventModel = EventModel.fromDomain(event);
      final userID = userDocument.id;

      await userDocument.update({
        "events": FieldValue.arrayUnion([event.id.value]),
      });

      await eventDocument.doc(eventModel.id).set(eventModel.toMap());
      await eventDocument.doc(eventModel.id).update({
        "admin": userID,
        "users": FieldValue.arrayUnion([userID])
      });

      return right(unit);
    } on FirebaseException {
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<EventFailure, Unit>> delete(Event event) {
    throw UnimplementedError();
  }

  @override
  Future<Either<EventFailure, Unit>> update(Event event) async {
    try {
      final userDoc = await firebase.userDocument();
      final eventModel = EventModel.fromDomain(event);

      await userDoc.eventCollection.doc(eventModel.id).set(eventModel.toMap());

      return right(unit);
    } on FirebaseException catch (exeption) {
      if (exeption.code.contains('permission-denied') ||
          exeption.code.contains("PERMISSION_DENIED")) {
        return left(UnexpectedFailure());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Stream<Either<EventFailure, List<Event>>> watchAllSubscriped() async* {
    final userid = await firebase.getUserID();

    yield* firebase
        .collection("events")
        .snapshots()
        .map((snapshot) => right<EventFailure, List<Event>>(snapshot.docs
            .map((doc) => EventModel.fromFirestore(doc).toDomain())
            .where((element) => element.users.contains(userid))
            .toList()))
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') ||
            e.code.contains("PERMISSION_DENIED")) {
          return left(UnexpectedFailure());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        return left(UnexpectedFailure());
      }
    });
  }

//!
  @override
  Stream<Either<EventFailure, List<Event>>> loadAllEvents() async* {
    final firebaseInstance = await firebase.eventDocument();

    yield* firebaseInstance
        .collection('events')
        .snapshots()
        .map((snapshot) => right<EventFailure, List<Event>>(snapshot.docs
            .map((doc) => EventModel.fromJson(doc.data()).toDomain())
            .toList()))
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') ||
            e.code.contains("PERMISSION_DENIED")) {
          return left(UnexpectedFailure());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        return left(UnexpectedFailure());
      }
    });
  }

  @override
  Future<Either<EventFailure, Unit>> addEventToUser(UniqueID eventID) async {
    final firebaseInstance = await firebase.eventDocument();
    final userID = await firebase.getUserID();

    try {
      await firebaseInstance.collection('events').doc(eventID.value).update({
        "users": FieldValue.arrayUnion([userID])
      });

      return right(unit);
    } on FirebaseException {
      return left(UnexpectedFailure());
    }
  }

  @override
  Stream<Either<EventFailure, Event>> loadEvent(String id) async* {
    final firebaseInstance = await firebase.eventDocument();
    //Fehler noch
    yield* firebaseInstance
        .collection('events')
        .where('id', isEqualTo: id)
        .snapshots()
        .map((snap) => right<EventFailure, Event>(
            EventModel.fromJson(snap.docs.first.data()).toDomain()))
        .handleError((e) {
      return left(UnexpectedFailure());
    });
  }

  @override
  Future<Either<EventFailure, Unit>> addMessageToEvent(
      String id, String message) async {
    final firebaseInstance = await firebase.eventDocument();

    try {
      await firebaseInstance.collection('events').doc(id).update({
        "eventMessages": FieldValue.arrayUnion([message])
      });

      return right(unit);
    } on FirebaseException {
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<EventFailure, List<Event>>> loadEventList() async {
    try {
      final fireStore = FirebaseFirestore.instance;

      var snap = await fireStore.collection('events').get();
      final allData = snap.docs
          .map((doc) => EventModel.fromMap(doc.data()).toDomain())
          .toList();

      return right(allData);
    } catch (e) {
      return left(UnexpectedFailure());
    }
  }
}
