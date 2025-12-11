import 'package:grizbee/src/domain/entities/transaction.dart';

abstract class TransactionLocalDatasource {
  Future<Transaction> getTransactionToPay();

  Future<List<Transaction>> getTransactions();
}
