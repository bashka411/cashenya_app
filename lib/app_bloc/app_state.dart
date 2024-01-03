part of 'app_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {

  final AuthStatus status;
  final User user;

  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user) : this._(status: AuthStatus.authenticated, user: user);
  const AppState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

    @override
  List<Object> get props => [status, user];
}
