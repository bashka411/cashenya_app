// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

enum LogInStatus { initial, submitting, success, error }

class LogInState extends Equatable {
  final String email;
  final String password;
  final LogInStatus status;
  final String? errorMessage;

  const LogInState({
    required this.email,
    required this.password,
    required this.status,
    this.errorMessage
  });

  factory LogInState.initial() {
    return const LogInState(
      email: '',
      password: '',
      status: LogInStatus.initial,
    );
  }

  LogInState copyWith({
    String? email,
    String? password,
    LogInStatus? status,
    String? errorMessage,
  }) {
    return LogInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
