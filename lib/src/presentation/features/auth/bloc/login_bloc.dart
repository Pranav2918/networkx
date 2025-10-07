import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkx/src/domain/repository/app_repository.dart';
import 'package:networkx/src/presentation/features/auth/bloc/login_event.dart';
import 'package:networkx/src/presentation/features/auth/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.appRepository}) : super(LoginRequestInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginRequested) {
        emit(LoginRequestLoading());
        try {
          final userData = await appRepository.login(
            event.email,
            event.password,
          );
          emit(LoginRequestApproved(user: userData));
        } catch (e) {
          emit(LoginRequestRejected(errorMessage: e.toString()));
        }
      }
    });
  }

  final AppRepository appRepository;
}
