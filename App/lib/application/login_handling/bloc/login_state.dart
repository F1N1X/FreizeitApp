// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class SignUpState {
  final Option<Either<AuthFailures, Unit>> authFailedOrSucced;

  SignUpState({required this.authFailedOrSucced});

  SignUpState copyWith({
    Option<Either<AuthFailures, Unit>>? authFailedOrSucced,
  }) {
    return SignUpState(
      authFailedOrSucced: authFailedOrSucced ?? this.authFailedOrSucced,
    );
  }
}
