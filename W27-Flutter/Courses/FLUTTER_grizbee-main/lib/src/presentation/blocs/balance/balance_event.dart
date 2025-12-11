part of 'balance_bloc.dart';

@immutable
abstract class BalanceEvent {}

class GetBalanceEvent extends BalanceEvent {}

class DepositFundsEvent extends BalanceEvent {
  final double amount;

  DepositFundsEvent(this.amount);
}
