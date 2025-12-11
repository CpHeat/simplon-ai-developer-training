import 'dart:math';

import 'package:grizbee/src/data/datasources/mock_contacts.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/presentation/utils/random_date.dart';

const int NB_GENERATED_TRANSACTIONS = 20;

List<Transaction> mockTransactions = [];

// Generate a transaction according to its "to paid" status
Transaction generateRandomTransaction({required bool isToPay}) {
  final Random random = Random();
  double transactionValue = isToPay ? (random.nextDouble() * random.nextInt(100)).abs() : (random.nextDouble() * random.nextInt(100));
  if (transactionValue == 0) transactionValue = 123.45;
  if (!isToPay) transactionValue = random.nextBool() ? transactionValue : transactionValue * -1;

  TransactionType transactionType = TransactionType.received;
  if (isToPay) {
    transactionType = TransactionType.purchase;
  } else if (transactionValue < 0) {
    while (transactionType == TransactionType.received) {
      transactionType = TransactionType.values[new Random().nextInt(TransactionType.values.length)];
    }
  }

  return Transaction(
    date: RandomDate.withRange(2020, 2021).random(),
    amount: transactionValue,
    fee: 0.0,
    currency: Currency.values[new Random().nextInt(Currency.values.length)],
    type: transactionType,
    contact: remoteContacts[Random().nextInt(remoteContacts.length)],
  );
}

// Generate a bunch of transactions sorted by date
List<Transaction> generateRandomTransactions({required bool isToPay}) {
  for (var i = 0; i < NB_GENERATED_TRANSACTIONS; i++) {
    mockTransactions.add(generateRandomTransaction(isToPay: isToPay));
  }

  return mockTransactions;
}

// Return a list of transactions according to transaction
List<Transaction> getTransactionsForTransaction(Transaction transaction) {
  List<Transaction> transactions = [];
  for (final t in mockTransactions) {
    // Only select transactions  that :
    // - are different from the given transaction
    // - concern the same contact
    if (t.id != transaction.id && t.contact.id == transaction.contact.id) transactions.add(t);
  }

  return transactions;
}
