import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/login/widgets/login_area_widget.dart';

import '../../../application/login_handling/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => serviceLocator<LoginBloc>(),
      child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: const LoginArea()),
    ));
  }
}
