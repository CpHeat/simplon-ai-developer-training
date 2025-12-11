import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<Transaction> getTransactionToPay();

  Future<List<Transaction>> getTransactions();

  Future<List<Transaction>> getTransactionsForContact(Transaction transaction);

  Future<Transaction> payTransaction(Transaction transaction);

  Future<Transaction> payContact(Contact contact, double amount);

  Future requestFunds(Contact contact, double amount);
}
