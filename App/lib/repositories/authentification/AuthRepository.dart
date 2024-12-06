// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:freizeit_app/Failures/register_failures.dart';
import 'package:freizeit_app/Failures/user_loading_error.dart';
import '../../Failures/authenticationfailure.dart';
import '../../entities/user.dart';

abstract class AuthRepository {
  Future<Either<RegisterFailure, Unit>> registerWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<AuthFailures, Unit>> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();

  Option<CustomUser> getSignedInUSer();

  Future<Either<AuthFailures, Unit>> sendEmailVerification();

  Future<Either<AuthFailures, bool>> isEmailVerifyed();

  Future<void> reloadUser();

  Future<void> deleteUserOfVerification();

  Future<void> deleteAndSignOutRegistredUser();

  Either<LoadingUserError, String> getUserId();

  Either<LoadingUserError, String?> getUserMail();
}
