// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'amount_input_cubit.dart';

enum AmountInputStatus { initial, invalid, valid, submitting }

@immutable
class AmountInputState extends Equatable {
  final String amount;
  final AmountInputStatus status;

  const AmountInputState({required this.amount, required this.status});

  factory AmountInputState.initial() {
    return const AmountInputState(amount: '0', status: AmountInputStatus.initial);
  }

  AmountInputState copyWith({
    String? amount,
    AmountInputStatus? status,
  }) {
    return AmountInputState(
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [amount, status];
}
