import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freizeit_app/Failures/authenticationfailure.dart';
import 'package:dartz/dartz.dart';
import 'package:freizeit_app/Failures/register_failures.dart';
import 'package:freizeit_app/Failures/user_loading_error.dart';
import 'package:freizeit_app/repositories/authentification/AuthRepository.dart';
import '../../entities/user.dart';
import 'package:freizeit_app/repositories/authentification/firebase_helper/Firestore_Usermapper.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override
  Future<Either<AuthFailures, Unit>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException {
      //Fehlerhandling mit exeption
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<RegisterFailure, Unit>> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .set({'id': user!.uid, 'email': email, 'messages': [], 'events': []});

      //!
      //FirebaseAuth.instance.currentUser!.sendEmailVerification();
      //firebaseAuth.currentUser!.sendEmailVerification;
      return right(unit);
    } on FirebaseAuthException {
      //Fehlerhandling exeption
      return left(UserAllreadyExist());
    }
  }

  @override
  Future<void> signOut() => Future.wait([
        firebaseAuth.signOut(),
      ]);

  @override
  Option<CustomUser> getSignedInUSer() =>
      optionOf(firebaseAuth.currentUser?.toDomain());

  @override
  Future<Either<AuthFailures, bool>> isEmailVerifyed() async {
    try {
      await reloadUser();
      //!
      final isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      //final isVerified = firebaseAuth.currentUser!.emailVerified;
      return right(isEmailVerify);
    } on FirebaseAuthException {
      return left(FailedOnProcess());
    }
  }

  @override
  Future<void> reloadUser() async {
    //!
    await FirebaseAuth.instance.currentUser!.reload();
    //await firebaseAuth.currentUser!.reload();
  }

  @override
  Future<Either<AuthFailures, Unit>> sendEmailVerification() async {
    try {
      //!Instance check
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      return right(unit);
    } on FirebaseAuthException {
      return left(FailedOnProcess());
    }
  }

  @override
  Future<void> deleteUserOfVerification() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAndSignOutRegistredUser() {
    throw UnimplementedError();
  }

  @override
  Either<LoadingUserError, String> getUserMail() {
    try {
      final mail = firebaseAuth.currentUser!.email;
      return right(mail!);
    } on FirebaseAuthException {
      return left(LoadingError());
    }
  }

  @override
  Either<LoadingUserError, String> getUserId() {
    try {
      final userID = firebaseAuth.currentUser!.uid;
      return right(userID);
    } on FirebaseAuthException {
      return left(LoadingError());
    }
  }
}
