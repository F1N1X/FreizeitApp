// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freizeit_app/errors/errors.dart';

import '../../../dependency_injection.dart';
import '../../authentification/AuthRepository.dart';

extension FireStorExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = serviceLocator<AuthRepository>().getSignedInUSer();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    final userIdValue = user.id.value;
    //! wenn es null ist für den Code aus wenn es some ist speicher es in user

    return FirebaseFirestore.instance.collection('users').doc(userIdValue);
    //auf den User dirigieren in der Datenbank
  }

  Future<String> getUserID() async {
    final userOption = serviceLocator<AuthRepository>().getSignedInUSer();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    return user.id.value;
  }

  Future<DocumentReference> eventDoc() async {
    //! wenn es null ist für den Code aus wenn es some ist speicher es in user

    return FirebaseFirestore.instance.collection('events').doc();
    //auf den User dirigieren in der Datenbank
  }

  Future<CollectionReference<Map<String, dynamic>>> eventDocTest() async {
    //! wenn es null ist für den Code aus wenn es some ist speicher es in user

    return FirebaseFirestore.instance.collection('events');
    //auf den User dirigieren in der Datenbank
  }

  Future<FirebaseFirestore> eventDocument() async {
    //! wenn es null ist für den Code aus wenn es some ist speicher es in user
    return FirebaseFirestore.instance;
    //auf den User dirigieren in der Datenbank
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserGroup(String userID) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .snapshots();
  }
}

extension DocumentReferencExt on DocumentReference {
  CollectionReference<Map<String, dynamic>> get eventCollection =>
      collection('event');
}
