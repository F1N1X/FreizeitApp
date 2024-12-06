import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freizeit_app/Failures/authenticationfailure.dart';
import 'package:freizeit_app/repositories/authentification/AuthRepository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerifiedState> {
  final AuthRepository authRepository;

  VerificationBloc({required this.authRepository})
      : super(VerifiedState(failedOrIsVerified: none())) {
    on<CheckVerification>((event, emit) async {
      final isVerified = await authRepository.isEmailVerifyed();
      emit(state.copyWith(failedOrIsVerified: optionOf(isVerified)));
    });

    on<ResendMail>((event, emit) async {
      await authRepository.sendEmailVerification();
    });

    on<CancelVerification>((event, emit) async {
      await authRepository.signOut();
    });
  }
}
