import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../repositories/authentification/AuthRepository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignOutPressedEvent>((event, emit) async {
      await authRepository.signOut();
      emit(AuthStateUnAuthenticated());
    });

    //Authenticated
    on<AuthCheckRequestedEvent>((event, emit) async {
      final userOption = authRepository.getSignedInUSer();
      //Option müssen gefoldet werden und reaction auf none/some die klammern
      userOption.fold(() => emit(AuthStateUnAuthenticated()),
          (a) => emit(AuthStateAuthenticated()));
    });
  }
}
