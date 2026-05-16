import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/auth/bloc/auth_event.dart';
import 'package:mobile/features/auth/bloc/auth_state.dart';
import 'package:mobile/features/auth/data/repositories/auth_repository.dart';

export  'auth_event.dart';
export  'auth_state.dart';

class AuthBloc 
  extends Bloc<AuthEvent, AuthState> {

    final AuthRepository repository;

    AuthBloc(this.repository)
    :super (AuthInitial()){

      on<LoginRequested>(_onLogin);

    }

    Future<void> _onLogin(
      LoginRequested event,
      Emitter<AuthState> emit,
    ) async {
      try{

        emit(AuthLoading());

        final token = await repository.login(
          email: event.email,
          password: event.password,
        );

        emit(AuthSuccess(token));
      }catch(e) {
        emit(AuthFailure(e.toString()));
      }
    }
  
}