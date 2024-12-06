part of 'verification_bloc.dart';

@immutable
abstract class VerificationEvent {}

class CheckVerification extends VerificationEvent {}

class ResendMail extends VerificationEvent {}

class CancelVerification extends VerificationEvent {}
