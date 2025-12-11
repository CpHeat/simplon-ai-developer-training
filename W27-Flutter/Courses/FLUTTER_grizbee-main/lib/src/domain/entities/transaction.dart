import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:flutter/cupertino.dart';

class Transaction {
  UniqueKey id = UniqueKey();
  DateTime date;
  double amount;
  double delivery = 0;
  double tax = 0;
  double fee;
  Currency currency;
  TransactionType type;
  Contact contact;

  Transaction({required this.date, required this.amount, required this.fee, required this.currency, required this.type, required this.contact});

  double get subtotalAmount {
    return amount + delivery + tax;
  }

  double get totalAmount {
    return subtotalAmount + fee;
  }
}

enum TransactionType { purchase, autoPayment, received, send }

enum Currency { euro, usd }

extension CurrencyExtension on Currency {
  // ignore: missing_return
  String get rawValue {
    switch (this) {
      case Currency.euro:
        return 'EUR';
      case Currency.usd:
        return 'USD';
    }
  }

  // ignore: missing_return
  String get symbol {
    switch (this) {
      case Currency.euro:
        return '€';
      case Currency.usd:
        return '\$';
    }
  }
}
