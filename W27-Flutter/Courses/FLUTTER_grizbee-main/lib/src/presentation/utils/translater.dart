import 'package:flutter/cupertino.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';

abstract class Translater {
  static String getTransactionTypeRawValue(BuildContext context, TransactionType type) {
    switch (type) {
      case TransactionType.purchase:
        return Translation.of(context).purchase;
      case TransactionType.autoPayment:
        return Translation.of(context).autoPayment;
      case TransactionType.received:
        return Translation.of(context).receivedMoney;
      case TransactionType.send:
        return Translation.of(context).sentMoney;
    }
  }
}
