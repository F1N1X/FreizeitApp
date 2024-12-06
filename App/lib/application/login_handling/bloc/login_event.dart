part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SignInWithEmailAndPasswordPressed extends LoginEvent {
  final String? email;
  final String? password;

  SignInWithEmailAndPasswordPressed(
      {required this.email, required this.password});
}

class RegisterWithEmailAndPasswordPressed extends LoginEvent {
  final String? email;
  final String? password;

  RegisterWithEmailAndPasswordPressed(
      {required this.email, required this.password});
}

class LoadUser extends LoginEvent {}
