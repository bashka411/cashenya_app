part of 'amount_display_cubit.dart';

@immutable
class AmountDisplayState extends Equatable {
  final double amount;

  const AmountDisplayState({required this.amount});

  factory AmountDisplayState.initial(){
    return const AmountDisplayState(amount: 0.0);
  }
  
  @override
  List<Object?> get props => [amount];
}
