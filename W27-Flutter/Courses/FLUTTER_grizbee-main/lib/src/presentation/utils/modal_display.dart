import 'package:flutter/material.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/utils/formatters.dart';

abstract class ModalSheet {
  static void show({required BuildContext context, required Widget content}) {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (BuildContext context) {
        return content;
      },
    );
  }
}

abstract class InfoSnackBar {
  static void showPaymentSnackBar(BuildContext context, Transaction transaction) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(Translation.of(context).paymentDone + ' : '),
            Text('${AmountFormatter.format(context, transaction.amount.abs())} ${transaction.currency.symbol}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  static void showFundsDepositSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Translation.of(context).accountFunded),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showFundsRequestSnackBar(BuildContext context, double amount) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(Translation.of(context).moneyRequestDone + ' : '),
            Text('$amount ${Currency.euro.symbol}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
