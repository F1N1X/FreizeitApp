import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/register_handling/bloc/register_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/register/register_page_content.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => serviceLocator<RegisterBloc>(),
      child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: const RegisterArea()),
    ));
  }
}
