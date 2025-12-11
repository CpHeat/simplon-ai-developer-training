class TransactionsException implements Exception {
  String get message => 'Something went wrong while fetching transactions';
}

class TransactionsForContactException implements Exception {
  String get message => 'Something went wrong while fetching transactions';
}

class TransactionToPayException implements Exception {
  String get message => 'Something went wrong while generating transaction';
}

class TransactionPaymentException implements Exception {
  String get message => 'Something went wrong while paying';
}

class ContactPaymentException implements Exception {
  String get message => 'Something went wrong while transferring money';
}

class MoneyRequestException implements Exception {
  String get message => 'Something went wrong while requesting funds';
}

