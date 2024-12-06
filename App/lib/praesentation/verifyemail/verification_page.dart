import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/verification/bloc/verification_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';
import 'package:freizeit_app/praesentation/verifyemail/verifyemail.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<VerificationBloc>(),
      child: const VerifyEmailPage(),
    );
  }
}
