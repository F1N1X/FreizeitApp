import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/auth_checker/bloc/auth_bloc.dart';
import 'package:freizeit_app/application/event_bloc/bloc/event_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/citymap/current_location.dart';
import 'package:freizeit_app/routes/router.gr.dart';

class CityPage extends StatelessWidget {
  const CityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<EventBloc>()..add(StartLoadingEvent()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateUnAuthenticated) {
                AutoRouter.of(context).replace(const LoginPageRoute());
              }
            },
          ),
          BlocListener<EventBloc, EventState>(
            listener: (context, state) {
              if (state is LoadingFailure) {
                //Fehler anzeigen // neue Route
                AutoRouter.of(context).replace(const WelcomeScreenRoute());
              }
            },
          ),
        ],
        //!CityMap überarbeiten
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventLoadingSucced) {
              return CurrentUserLocation(
                events: state.events,
                position: state.position,
                key: UniqueKey(),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
