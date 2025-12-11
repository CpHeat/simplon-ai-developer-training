import 'package:get_it/get_it.dart';
import 'package:grizbee/src/data/abstraction/transaction_local_datasource.dart';
import 'package:grizbee/src/data/abstraction/transaction_remote_datasource.dart';
import 'package:grizbee/src/domain/abstraction/transaction_repository.dart';
import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final transactionLocalDatasource = GetIt.instance.get<TransactionLocalDatasource>();
  final transactionRemoteDatasource = GetIt.instance.get<TransactionRemoteDatasource>();

  @override
  Future<Transaction> getTransactionToPay() {
    return transactionLocalDatasource.getTransactionToPay();
  }

  @override
  Future<List<Transaction>> getTransactions() {
    return transactionLocalDatasource.getTransactions();
  }

  @override
  Future<Transaction> payTransaction(Transaction transaction) async {
    return transactionRemoteDatasource.payTransaction(transaction);
  }

  @override
  Future<List<Transaction>> getTransactionsForContact(Transaction transaction) {
    return transactionRemoteDatasource.getTransactionsForContact(transaction);
  }

  @override
  Future<Transaction> payContact(Contact contact, double amount) {
    return transactionRemoteDatasource.payContact(contact, amount);
  }

  @override
  Future requestFunds(Contact contact, double amount) {
    return transactionRemoteDatasource.requestFunds(contact, amount);
  }
}
