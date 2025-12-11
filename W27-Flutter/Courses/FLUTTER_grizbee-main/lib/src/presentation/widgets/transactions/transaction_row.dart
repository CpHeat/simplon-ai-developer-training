import 'package:flutter/material.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/presentation/utils/formatters.dart';
import 'package:grizbee/src/presentation/utils/translater.dart';
import 'package:grizbee/src/presentation/widgets/avatars/avatar_in_row.dart';

// This widget provides row for list of transactions
class TransactionRow extends StatelessWidget {
  final Transaction transaction;

  TransactionRow({required this.transaction});

  @override
  Widget build(BuildContext context) {
    String contactPicture = transaction.contact.picture ?? '';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        children: [
          // Image of the contact concerned by the transaction
          AvatarInRow(picture: contactPicture),
          // Info of the transaction
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name of the contact concerned by the transaction
                  Text(transaction.contact.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  // Date of the transaction
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(DateFormatter.format(context, transaction.date), style: TextStyle(color: Colors.grey)),
                  ),
                  // Type of the transaction
                  Text(Translater.getTransactionTypeRawValue(context, transaction.type), style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          // Value of the transaction
          Row(
            children: [
              // Amount
              if (transaction.amount > 0) Text('+', style: TextStyle(color: Colors.green)),
              Text(
                AmountFormatter.format(context, transaction.amount),
                style: TextStyle(color: transaction.amount > 0 ? Colors.green : Colors.black),
              ),
              // Symbol of the currency
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  transaction.currency.rawValue,
                  style: TextStyle(color: transaction.amount > 0 ? Colors.green : Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
