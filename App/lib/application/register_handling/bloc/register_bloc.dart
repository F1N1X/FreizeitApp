import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freizeit_app/repositories/authentification/AuthRepository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../Failures/register_failures.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository})
      : super(RegisterState(registerOrFailure: none())) {
    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      final succedOrFailed = await authRepository.registerWithEmailAndPassword(
          email: event.email!, password: event.password!);

      emit(state.copyWith(registerOrFailure: optionOf(succedOrFailed)));
    });
  }
}
