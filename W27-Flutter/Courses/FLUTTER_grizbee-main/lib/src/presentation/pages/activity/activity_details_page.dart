import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/pages/activity/activity_similar_page.dart';
import 'package:grizbee/src/presentation/utils/formatters.dart';
import 'package:grizbee/src/presentation/utils/modal_display.dart';
import 'package:grizbee/src/presentation/utils/translater.dart';
import 'package:grizbee/src/presentation/widgets/avatars/contact_avatar.dart';
import 'package:grizbee/src/presentation/widgets/sheets/bottom_sheets.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar_section_navigator.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetailsPageArguments {
  final Transaction transaction;
  final bool showSimilarTransactions;

  ActivityDetailsPageArguments({required this.transaction, required this.showSimilarTransactions});
}

class ActivityDetailsPage extends StatelessWidget {
  final ActivityDetailsPageArguments args;

  ActivityDetailsPage({required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormatter.format(context, args.transaction.date)),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TransactionHeader(transaction: args.transaction),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 60.0),
              child: Column(
                children: [
                  _TransactionType(transaction: args.transaction),
                  SizedBox(height: 40),
                  _TransactionDetails(transaction: args.transaction),
                  SizedBox(height: 40),
                  _TransactionContact(transaction: args.transaction, showSimilar: args.showSimilarTransactions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionHeader extends StatelessWidget {
  final Transaction transaction;

  _TransactionHeader({required this.transaction});

  @override
  Widget build(BuildContext context) {
    String contactPicture = transaction.contact.picture ?? '';
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            ContactAvatar(picture: contactPicture),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  transaction.type != TransactionType.received ? Translation.of(context).youHavePaid : Translation.of(context).youHaveReceived,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${AmountFormatter.format(context, transaction.amount.abs())} ${transaction.currency.rawValue}',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
            Text(
              transaction.type != TransactionType.received ? Translation.of(context).to : Translation.of(context).from,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              transaction.contact.name,
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}

class _TransactionType extends StatelessWidget {
  final Transaction transaction;

  _TransactionType({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translation.of(context).typeOfTransaction.toUpperCase(), style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text(Translater.getTransactionTypeRawValue(context, transaction.type)),
        ],
      ),
    );
  }
}

class _TransactionDetails extends StatelessWidget {
  final Transaction transaction;

  _TransactionDetails({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translation.of(context).detailsOfTransaction.toUpperCase(), style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          _TransactionDetailsRow(title: Translation.of(context).amount, amount: transaction.amount, currency: transaction.currency),
          transaction.type != TransactionType.received
              ? Column(
                  children: [
                    SizedBox(height: 10),
                    _TransactionDetailsRow(title: Translation.of(context).delivery, amount: transaction.delivery, currency: transaction.currency),
                    SizedBox(height: 10),
                    _TransactionDetailsRow(title: Translation.of(context).tax, amount: transaction.tax, currency: transaction.currency),
                    SizedBox(height: 10),
                    _TransactionDetailsRow(title: Translation.of(context).subtotal, amount: transaction.subtotalAmount, currency: transaction.currency),
                    Divider(),
                  ],
                )
              : SizedBox.shrink(),
          SizedBox(height: 10),
          _TransactionDetailsRow(title: Translation.of(context).fee, amount: transaction.fee, currency: transaction.currency),
          SizedBox(height: 20),
          _TransactionDetailsRow(title: Translation.of(context).total, amount: transaction.totalAmount, currency: transaction.currency),
          Divider(),
        ],
      ),
    );
  }
}

class _TransactionDetailsRow extends StatelessWidget {
  final String title;
  final double amount;
  final Currency currency;

  _TransactionDetailsRow({required this.title, required this.amount, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title.toUpperCase()), Text('${AmountFormatter.format(context, amount.abs())} ${currency.rawValue}'.toUpperCase())],
    );
  }
}

class _TransactionContact extends StatelessWidget {
  final Transaction transaction;
  final bool showSimilar;

  _TransactionContact({required this.transaction, required this.showSimilar});

  Future<void> _launchEmail() async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: transaction.contact.email,
      query: 'subject=Contact', // Ajout du paramètre de sujet
    );

    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch $emailUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${Translation.of(context).youAnd}  ${transaction.contact.name.toUpperCase()}', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          GestureDetector(
            child: _TransactionContactRow(
              iconData: CupertinoIcons.mail,
              title: '${Translation.of(context).toContact} ${transaction.contact.name}',
            ),
            onTap: () => ModalSheet.show(
              context: context,
              content: TwoButtonsSheet(title: transaction.contact.email, action: _launchEmail),
            ),
          ),
          Divider(),
          if (showSimilar)
            Column(
              children: [
                SizedBox(height: 10),
                GestureDetector(
                  child: _TransactionContactRow(iconData: CupertinoIcons.list_bullet, title: Translation.of(context).similarTransactions),
                  onTap: () => Navigator.pushNamed(context, RouteName.activity_similar, arguments: ActivitySimilarPageArguments(transaction: transaction)),
                ),
                Divider(),
              ],
            ),
        ],
      ),
    );
  }
}

class _TransactionContactRow extends StatelessWidget {
  final IconData iconData;
  final String title;

  _TransactionContactRow({required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: Theme.of(context).colorScheme.secondary),
        SizedBox(width: 20),
        Expanded(child: Text(title)),
        Icon(CupertinoIcons.right_chevron, color: Theme.of(context).colorScheme.secondary),
      ],
    );
  }
}
