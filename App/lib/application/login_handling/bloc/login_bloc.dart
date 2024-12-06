import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freizeit_app/Failures/authenticationfailure.dart';
import 'package:freizeit_app/repositories/authentification/AuthRepository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, SignUpState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository})
      : super(SignUpState(authFailedOrSucced: none())) {
    on<SignInWithEmailAndPasswordPressed>((event, emit) async {
      //Validations email/pass
      final failOrSuccesLogin = await authRepository.loginWithEmailAndPassword(
          email: event.email!, password: event.password!);

      emit(state.copyWith(authFailedOrSucced: optionOf(failOrSuccesLogin)));
    });
  }
}
