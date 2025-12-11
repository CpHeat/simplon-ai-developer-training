part of 'balance_bloc.dart';

@immutable
abstract class BalanceState {
  final double? value;

  BalanceState({this.value});
}

class BalanceInitial extends BalanceState {}



// region --- BALANCE ---
class BalanceLoading extends BalanceState {}

class BalanceLoaded extends BalanceState {
  BalanceLoaded(value) : super(value: value);
}
class BalanceFailure extends BalanceState {
  final String message;

  BalanceFailure(this.message);
}
// endregion

// region --- FUNDS DEPOSIT ---
class FundsDepositProcessing extends BalanceState {}

class FundsDepositProceeded extends BalanceState {
  FundsDepositProceeded(value) : super(value: value);
}

class FundsDepositFailure extends BalanceState {
  final String message;

  FundsDepositFailure(this.message);

}
// endregion
