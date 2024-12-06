// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterWithEmailAndPasswordPressed extends RegisterEvent {
  final String? email;
  final String? password;
  RegisterWithEmailAndPasswordPressed({
    this.email,
    this.password,
  });
}
