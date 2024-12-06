import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freizeit_app/repositories/authentification/AuthRepository.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../Failures/user_loading_error.dart';

part 'userinformation_event.dart';
part 'userinformation_state.dart';

class UserinformationBloc
    extends Bloc<UserinformationEvent, UserInformationState> {
  final AuthRepository authRepository;

  UserinformationBloc({required this.authRepository}) : super(UserInitial()) {
    Future<Position> currentUserLocation() async {
      bool gpsIsEnable;
      LocationPermission permission;

      gpsIsEnable = await Geolocator.isLocationServiceEnabled();

      if (!gpsIsEnable) {
        return Future.error('Location service is disable');
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error("Location permission dinied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error('Go to Setting and change Permissions');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      return position;
    }

    on<StartLoadUserInformation>((event, emit) {
      emit(LoadUserInformation());
      final userData = authRepository.getUserMail();
      add(GetUserMail(userData));
    });

    on<StartLoadUserInformationTest>((event, emit) {
      final userData = authRepository.getUserMail();
      add(GetUserMail(userData));
    });

    on<GetUserMail>((event, emit) {
      event.failedOrUserdata.fold(
          (failed) => emit(LoadingUserFailed(failed: failed)),
          (mail) => emit(LoadingUserSucceded(email: mail!)));
    });

    on<GetUserGeoData>((event, emit) async {
      final position = await currentUserLocation();
      emit(LoadedUserGeoData(geodata: position));
    });
  }
}
