// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'verification_bloc.dart';

class VerifiedState {
  final Option<Either<AuthFailures, bool>> failedOrIsVerified;
  VerifiedState({
    required this.failedOrIsVerified,
  });

  VerifiedState copyWith({
    Option<Either<AuthFailures, bool>>? failedOrIsVerified,
  }) {
    return VerifiedState(
      failedOrIsVerified: failedOrIsVerified ?? this.failedOrIsVerified,
    );
  }
}
