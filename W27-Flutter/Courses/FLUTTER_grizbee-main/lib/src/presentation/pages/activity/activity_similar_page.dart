import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grizbee/src/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/pages/activity/activity_details_page.dart';
import 'package:grizbee/src/presentation/utils/modal_display.dart';
import 'package:grizbee/src/presentation/widgets/avatars/contact_avatar.dart';
import 'package:grizbee/src/presentation/widgets/loaders/loader_full_page.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar_section_navigator.dart';
import 'package:grizbee/src/presentation/widgets/transactions/transaction_row.dart';

class ActivitySimilarPageArguments {
  final Transaction transaction;

  ActivitySimilarPageArguments({required this.transaction});
}

class ActivitySimilarPage extends StatefulWidget {
  final ActivitySimilarPageArguments args;

  ActivitySimilarPage({required this.args});

  @override
  _ActivitySimilarPageState createState() => _ActivitySimilarPageState();
}

class _ActivitySimilarPageState extends State<ActivitySimilarPage> {
  @override
  void initState() {
    context.read<TransactionContactBloc>().add(GetTransactionsForContactEvent(widget.args.transaction));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Translation.of(context).similarTransactions)),
      body: BlocConsumer<TransactionContactBloc, TransactionState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case TransactionsForContactFailure:
              InfoSnackBar.showErrorSnackBar(context, (state as TransactionsForContactFailure).message);
              break;
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case TransactionsForContactLoading:
              return Column(
                children: [
                  _Header(contact: widget.args.transaction.contact),
                  Expanded(child: LoaderFullPage()),
                ],
              );

            case TransactionsForContactLoaded:
              final transactions = (state as TransactionsForContactLoaded).transactions;
              return transactions.isNotEmpty
                  ? SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          _Header(contact: widget.args.transaction.contact),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: _ListOfTransactions(transactions: transactions),
                          )
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        _Header(contact: widget.args.transaction.contact),
                        Expanded(
                          child: Container(
                            child: Center(child: Text(Translation.of(context).noAdditionalTransactions)),
                          ),
                        ),
                      ],
                    );
            default:
              return Column(
                children: [
                  _Header(contact: widget.args.transaction.contact),
                  Expanded(
                    child: Container(
                      child: Center(child: Text(Translation.of(context).noAdditionalTransactions)),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Contact contact;

  _Header({required this.contact});

  @override
  Widget build(BuildContext context) {
    String contactPicture = contact.picture ?? '';
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            ContactAvatar(picture: contactPicture),
            SizedBox(height: 12),
            Text(
              Translation.of(context).yourActivityWith,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              contact.name,
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}

class _ListOfTransactions extends StatelessWidget {
  final List<Transaction> transactions;

  _ListOfTransactions({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var transaction in transactions)
          GestureDetector(
            child: TransactionRow(transaction: transaction),
            onTap: () => {
              Navigator.pushNamed(
                context,
                RouteName.activity_details,
                arguments: ActivityDetailsPageArguments(transaction: transaction, showSimilarTransactions: false),
              )
            },
          ),
      ],
    );
  }
}
