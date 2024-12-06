import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/auth_checker/bloc/auth_bloc.dart';
import 'package:freizeit_app/application/event_bloc/bloc/event_bloc.dart';
import 'package:freizeit_app/routes/router.gr.dart' as router;
import 'package:freizeit_app/dependency_injection.dart' as dependency_injector;

import 'dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dependency_injector.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = router.AppRouter();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                serviceLocator<AuthBloc>()..add(AuthCheckRequestedEvent())),
        BlocProvider(
            create: (context) =>
                serviceLocator<EventBloc>()..add(LoadingSubscripedEvent())),
      ],
      child: MaterialApp.router(
        //Router hinzufügen
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        title: 'Freetisimo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
