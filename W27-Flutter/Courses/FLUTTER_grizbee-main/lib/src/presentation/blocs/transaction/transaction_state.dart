part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

// region --- TRANSACTIONS ---
class TransactionsLoading extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  final List<Transaction> transactions;

  TransactionsLoaded(this.transactions);
}

class TransactionsFailure extends TransactionState {
  final String message;

  TransactionsFailure(this.message);
}
// endregion

// region --- TRANSACTIONS FOR CONTACT ---
class TransactionsForContactLoading extends TransactionState {}

class TransactionsForContactLoaded extends TransactionState {
  final List<Transaction> transactions;

  TransactionsForContactLoaded(this.transactions);
}

class TransactionsForContactFailure extends TransactionState {
  final String message;

  TransactionsForContactFailure(this.message);
}
// endregion

// region --- TRANSACTION TO PAY ---
class TransactionToPayLoading extends TransactionState {}

class TransactionToPayLoaded extends TransactionState {
  final Transaction transaction;

  TransactionToPayLoaded(this.transaction);
}

class TransactionToPayFailure extends TransactionState {
  final String message;

  TransactionToPayFailure(this.message);
}
// endregion

// region --- TRANSACTION PAYMENT ---
class TransactionPaymentProcessing extends TransactionState {}

class TransactionPaymentProceeded extends TransactionState {
  final Transaction transaction;

  TransactionPaymentProceeded(this.transaction);
}

class TransactionPaymentFailure extends TransactionState {
  final String message;

  TransactionPaymentFailure(this.message);
}
// endregion

// region --- CONTACT PAYMENT ---
class ContactPaymentProcessing extends TransactionState {}

class ContactPaymentProceeded extends TransactionState {
  final Transaction transaction;

  ContactPaymentProceeded(this.transaction);
}

class ContactPaymentFailure extends TransactionState {
  final String message;

  ContactPaymentFailure(this.message);
}
// endregion

// region --- FUNDS REQUEST ---
class MoneyRequestProcessing extends TransactionState {}

class MoneyRequestProceeded extends TransactionState {
  final double amount;

  MoneyRequestProceeded(this.amount);
}

class MoneyRequestFailure extends TransactionState {
  final String message;

  MoneyRequestFailure(this.message);
}
// endregion
