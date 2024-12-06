// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freizeit_app/entities/id.dart';
import 'package:freizeit_app/entities/user.dart';

extension FirebaseUserMapper on User {
  CustomUser toDomain() {
    return CustomUser(id: UniqueID.fromUniqueString(uid));
  }
}
