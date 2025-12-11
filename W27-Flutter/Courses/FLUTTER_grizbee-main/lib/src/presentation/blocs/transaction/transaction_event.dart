part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class GetTransactionToPayEvent extends TransactionEvent {}

class PayTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  PayTransactionEvent(this.transaction);
}

class GetTransactionsEvent extends TransactionEvent {}

class GetTransactionsForContactEvent extends TransactionEvent {
  final Transaction transaction;

  GetTransactionsForContactEvent(this.transaction);
}

class PayContactEvent extends TransactionEvent {
  final Contact contact;
  final double amount;

  PayContactEvent(this.contact, this.amount);
}

class RequestFundsEvent extends TransactionEvent {
  final Contact contact;
  final double amount;

  RequestFundsEvent(this.contact, this.amount);
}