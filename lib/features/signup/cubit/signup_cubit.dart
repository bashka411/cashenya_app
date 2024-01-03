import 'package:cashenya_app/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;
  SignUpCubit(this._authRepository) : super(SignUpState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(email: value, status: SignUpStatus.initial),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(password: value, status: SignUpStatus.initial),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (state.status == SignUpStatus.submitting) return;
    emit(state.copyWith(status: SignUpStatus.submitting, email: state.email, password: state.password));
    try {
      await _authRepository.signUp(email: state.email, password: state.password);
      emit(state.copyWith(status: SignUpStatus.success));
    } catch (err) {
      emit(state.copyWith(status: SignUpStatus.error, errorMessage: err.toString()));
    }
  }
}
