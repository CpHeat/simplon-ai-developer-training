import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grizbee/src/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/utils/formatters.dart';
import 'package:grizbee/src/presentation/widgets/avatars/contact_avatar.dart';
import 'package:grizbee/src/presentation/widgets/buttons/rounded_button.dart';

class TransactionPaymentModal extends StatelessWidget {
  final Transaction transaction;

  TransactionPaymentModal({required this.transaction});

  @override
  Widget build(BuildContext context) {
    String contactPicture = transaction.contact.picture ?? '';
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ContactAvatar(picture: contactPicture),
            SizedBox(height: 10),
            Text(transaction.contact.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(Translation.of(context).payThisContact, style: TextStyle(fontSize: 20)),
                Text('${AmountFormatter.format(context, transaction.amount)} ${transaction.currency.symbol}', style: TextStyle(fontSize: 40, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              child: RoundedButton(
                title: Translation.of(context).cancel,
                backgroundColor: Colors.red,
              ),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 20),
            GestureDetector(
              child: RoundedButton(
                title: Translation.of(context).validatePayment,
                backgroundColor: Colors.grey,
              ),
              onTap: () {
                context.read<TransactionPaymentBloc>().add(PayTransactionEvent(transaction));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
