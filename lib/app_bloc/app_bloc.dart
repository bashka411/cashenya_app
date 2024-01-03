import 'dart:async';

import 'package:cashenya_app/auth_repository.dart';
import 'package:cashenya_app/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<User>? _userSubscription;

  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppLogoutRequestEvent>(_onLogoutRequestEvent);
    on<AppUserChangedEvent>(_onUserChangedEvent);

    _userSubscription = _authRepository.user.listen(
      (user) => add(AppUserChangedEvent(user)),
    );
    
  }

  void _onLogoutRequestEvent(AppLogoutRequestEvent event, Emitter<AppState> emit) {
    _authRepository.signOut();
  }

  void _onUserChangedEvent(AppUserChangedEvent event, Emitter<AppState> emit) {
    print('User changed. Email: ${event.user.email}');
    emit(
      event.user.isNotEmpty ? AppState.authenticated(event.user) : const AppState.unauthenticated(),
    );
    print('Auth status: ${state.status}');
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
