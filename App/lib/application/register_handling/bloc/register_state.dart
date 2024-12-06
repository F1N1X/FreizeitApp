part of 'register_bloc.dart';

class RegisterState {
  final Option<Either<RegisterFailure, Unit>> registerOrFailure;

  RegisterState({required this.registerOrFailure});

  RegisterState copyWith({
    Option<Either<RegisterFailure, Unit>>? registerOrFailure,
  }) {
    return RegisterState(
      registerOrFailure: registerOrFailure ?? this.registerOrFailure,
    );
  }
}
