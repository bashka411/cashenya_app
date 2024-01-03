part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequestEvent extends AppEvent {}

class AppUserChangedEvent extends AppEvent {
  const AppUserChangedEvent(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
