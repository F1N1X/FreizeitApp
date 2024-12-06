part of 'userinformation_bloc.dart';

@immutable
abstract class UserInformationState {}

class LoadingUserSucceded extends UserInformationState {
  final String email;

  LoadingUserSucceded({required this.email});
}

class LoadingUserFailed extends UserInformationState {
  final LoadingUserError failed;

  LoadingUserFailed({required this.failed});
}

class LoadUserInformation extends UserInformationState {}

class UserInitial extends UserInformationState {}

class LoadedUserGeoData extends UserInformationState {
  final Position geodata;

  LoadedUserGeoData({required this.geodata});
}
