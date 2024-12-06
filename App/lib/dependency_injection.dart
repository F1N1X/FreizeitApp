import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freizeit_app/application/auth_checker/bloc/auth_bloc.dart';
import 'package:freizeit_app/application/event_bloc/bloc/event_bloc.dart';
import 'package:freizeit_app/application/event_detail/bloc/event_detail_bloc.dart';
import 'package:freizeit_app/application/event_finder_bloc/bloc/event_finder_bloc.dart';
import 'package:freizeit_app/application/event_form_bloc/bloc/event_form_bloc.dart';
import 'package:freizeit_app/application/event_update_bloc/bloc/eventupdate_bloc.dart';
import 'package:freizeit_app/application/message_handling/bloc/message_bloc.dart';
import 'package:freizeit_app/application/register_handling/bloc/register_bloc.dart';
import 'package:freizeit_app/application/user_information/bloc/userinformation_bloc.dart';
import 'package:freizeit_app/application/verification/bloc/verification_bloc.dart';
import 'package:freizeit_app/repositories/authentification/AuthRepository.dart';
import 'package:freizeit_app/repositories/authentification/AuthRepositoryImp.dart';
import 'package:freizeit_app/repositories/event/eventrepo_impl.dart';
import 'package:freizeit_app/repositories/event/eventrepository.dart';
import 'package:get_it/get_it.dart';

import 'application/login_handling/bloc/login_bloc.dart';

final serviceLocator = GetIt.I;

Future<void> init() async {
  //? Auth

  //StateManagement
  serviceLocator
      .registerFactory(() => LoginBloc(authRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => EventBloc(eventRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => AuthBloc(authRepository: serviceLocator()));

  serviceLocator
      .registerFactory(() => EventFormBloc(eventRepository: serviceLocator()));

  serviceLocator
      .registerFactory(() => RegisterBloc(authRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => VerificationBloc(authRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => UserinformationBloc(authRepository: serviceLocator()));

  serviceLocator.registerFactory(() => EventDetailBloc(
      eventRepository: serviceLocator(), authRepository: serviceLocator()));

  serviceLocator
      .registerFactory(() => MessageBloc(eventRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => EventupdateBloc(eventRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => EventFinderBloc(eventRepository: serviceLocator()));

  //Repository
  serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: serviceLocator()));
  serviceLocator.registerLazySingleton<EventRepository>(
      () => EventRepositoryImp(firebase: serviceLocator()));

  //Firebase extern
  final firestore = FirebaseFirestore.instance;
  serviceLocator.registerLazySingleton(() => firestore);

  final firebaseAuth = FirebaseAuth.instance;
  serviceLocator.registerLazySingleton(() => firebaseAuth);
}
