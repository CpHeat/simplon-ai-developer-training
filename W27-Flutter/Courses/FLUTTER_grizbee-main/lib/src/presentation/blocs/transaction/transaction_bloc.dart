import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:grizbee/src/domain/abstraction/transaction_repository.dart';
import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/domain/exceptions/transaction_exception.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

// Bloc for global transactions
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final transactionRepository = GetIt.instance.get<TransactionRepository>();

  TransactionBloc() : super(TransactionInitial()) {
    // Gestion de GetTransactionsEvent
    on<GetTransactionsEvent>((event, emit) async {
      try {
        emit(TransactionsLoading());
        final transactions = await transactionRepository.getTransactions();
        transactions.sort((a, b) => b.date.compareTo(a.date));
        emit(TransactionsLoaded(transactions));
      } catch (error) {
        if (error is TransactionsException) {
          emit(TransactionsFailure(error.message));
        }
      }
    });
  }
}

// Bloc for contact transactions
class TransactionContactBloc extends Bloc<TransactionEvent, TransactionState> {
  final transactionRepository = GetIt.instance.get<TransactionRepository>();

  TransactionContactBloc() : super(TransactionInitial()) {
    // Gestion de GetTransactionsForContactEvent
    on<GetTransactionsForContactEvent>((event, emit) async {
      try {
        emit(TransactionsForContactLoading());
        final transactions = await transactionRepository.getTransactionsForContact(event.transaction);
        transactions.sort((a, b) => b.date.compareTo(a.date));
        emit(TransactionsForContactLoaded(transactions));
      } catch (error) {
        if (error is TransactionsForContactException) {
          emit(TransactionsForContactFailure(error.message));
        }
      }
    });

    // Gestion de PayContactEvent
    on<PayContactEvent>((event, emit) async {
      try {
        emit(ContactPaymentProcessing());
        final transaction = await transactionRepository.payContact(event.contact, event.amount);
        emit(ContactPaymentProceeded(transaction));
      } catch (error) {
        if (error is ContactPaymentException) {
          emit(ContactPaymentFailure(error.message));
        }
      }
    });

    // Gestion de RequestFundsEvent
    on<RequestFundsEvent>((event, emit) async {
      try {
        emit(MoneyRequestProcessing());
        await transactionRepository.requestFunds(event.contact, event.amount);
        emit(MoneyRequestProceeded(event.amount));
      } catch (error) {
        if (error is MoneyRequestException) {
          emit(MoneyRequestFailure(error.message));
        }
      }
    });
  }
}

// Bloc for transaction payment
class TransactionPaymentBloc extends Bloc<TransactionEvent, TransactionState> {
  final transactionRepository = GetIt.instance.get<TransactionRepository>();

  TransactionPaymentBloc() : super(TransactionInitial()) {
    // Gestion de GetTransactionToPayEvent
    on<GetTransactionToPayEvent>((event, emit) async {
      try {
        emit(TransactionToPayLoading());
        final transaction = await transactionRepository.getTransactionToPay();
        emit(TransactionToPayLoaded(transaction));
      } catch (error) {
        if (error is TransactionToPayException) {
          emit(TransactionToPayFailure(error.message));
        }
      }
    });

    // Gestion de PayTransactionEvent
    on<PayTransactionEvent>((event, emit) async {
      try {
        emit(TransactionPaymentProcessing());
        final returnedTransaction = await transactionRepository.payTransaction(event.transaction);
        emit(TransactionPaymentProceeded(returnedTransaction));
      } catch (error) {
        if (error is TransactionPaymentException) {
          emit(TransactionPaymentFailure(error.message));
        }
      }
    });
  }
}
