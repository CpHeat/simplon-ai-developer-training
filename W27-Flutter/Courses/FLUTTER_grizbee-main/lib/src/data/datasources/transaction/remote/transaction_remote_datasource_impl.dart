import 'package:grizbee/src/data/abstraction/transaction_remote_datasource.dart';
import 'package:grizbee/src/data/datasources/mock_balance.dart';
import 'package:grizbee/src/data/datasources/mock_constants.dart';
import 'package:grizbee/src/data/datasources/mock_transactions.dart';
import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/domain/exceptions/transaction_exception.dart';

class TransactionRemoteDatasourceImpl implements TransactionRemoteDatasource {
  @override
  Future<Transaction> getTransactionToPay() {
    // Simulation : fetching data from API
    return Future.delayed(Duration(seconds: FetchDataDelay.remote), () async {
      try {
        return generateRandomTransaction(isToPay: true);
      } catch (error) {
        throw (TransactionToPayException());
      }
    });
  }

  @override
  Future<List<Transaction>> getTransactions() {
    // Simulation : fetching data from API
    return Future.delayed(Duration(seconds: FetchDataDelay.remote), () async {
      try {
        return generateRandomTransactions(isToPay: false);
      } catch (error) {
        throw (TransactionsException());
      }
    });
  }

  @override
  Future<Transaction> payTransaction(Transaction transaction) {
    // Simulation : fetching data from API
    return Future.delayed(Duration(seconds: FetchDataDelay.remote), () async {
      try {
        // Add transaction to mock
        transaction.date = DateTime.now();
        mockBalance -= transaction.amount;
        transaction.amount = transaction.amount * -1;
        mockTransactions.add(transaction);
        return transaction;
      } catch (error) {
        throw (TransactionPaymentException());
      }
    });
  }

  @override
  Future<List<Transaction>> getTransactionsForContact(Transaction transaction) {
    // Simulation : fetching data from API
    return Future.delayed(Duration(seconds: FetchDataDelay.remote), () async {
      try {
        return getTransactionsForTransaction(transaction);
      } catch (error) {
        throw (TransactionsForContactException());
      }
    });
  }

  @override
  Future<Transaction> payContact(Contact contact, double amount) {
    // Simulation API call
    return Future.delayed(Duration(seconds: FetchDataDelay.remote), () async {
      try {
        final transaction = Transaction(
          contact: contact,
          amount: amount * -1,
          currency: Currency.euro,
          date: DateTime.now(),
          fee: 2.15,
          type: TransactionType.send,
        );
        mockTransactions.add(transaction);
        mockBalance -= amount;
        return transaction;
      } catch (error) {
        throw (ContactPaymentException());
      }
    });
  }

  @override
  Future requestFunds(Contact contact, double amount) {
    // Simulation : fetching data from API
    return Future.delayed(Duration(seconds: FetchDataDelay.remote), () async {
      try {
        return;
      } catch (error) {
        throw (MoneyRequestException());
      }
    });
  }
}
