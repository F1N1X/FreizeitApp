part of 'userinformation_bloc.dart';

@immutable
abstract class UserinformationEvent {}

class GetUserMail extends UserinformationEvent {
  final Either<LoadingUserError, String?> failedOrUserdata;

  GetUserMail(this.failedOrUserdata);
}

class CleanUserMail extends UserinformationEvent {}

class StartLoadUserInformation extends UserinformationEvent {}

class StartLoadUserInformationTest extends UserinformationEvent {}

class GetUserGeoData extends UserinformationEvent {}
