import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grizbee/src/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/pages/activity/activity_details_page.dart';
import 'package:grizbee/src/presentation/utils/modal_display.dart';
import 'package:grizbee/src/presentation/widgets/cards/base_card.dart';
import 'package:grizbee/src/presentation/widgets/loaders/loader_in_widget.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar_section_navigator.dart';
import 'package:grizbee/src/presentation/widgets/transactions/transaction_row.dart';

class RecentActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case TransactionsFailure:
            InfoSnackBar.showErrorSnackBar(context, (state as TransactionsFailure).message);
            break;
        }
      },
      child: BaseCard(
          content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translation.of(context).recentActivity,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Display most recent transactions
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                // LOADING state
                case TransactionsLoading:
                  return LoaderInWidget();
                // LOADED state
                case TransactionsLoaded:
                  return _ListOfRecentActivities(transactions: (state as TransactionsLoaded).transactions);
                // OTHER state
                default:
                  return Center(child: Text(Translation.of(context).noActivity));
              }
            },
          ),

          Divider(),
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.list_sharp, color: Colors.blue.shade700),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      Translation.of(context).seeAllActivities,
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Icon(CupertinoIcons.chevron_right),
              ],
            ),
            onTap: () => {Navigator.pushNamed(context, RouteName.activity)},
          ),
        ],
      )),
    );
  }
}

class _ListOfRecentActivities extends StatelessWidget {
  static const int NB_ACTIVITIES_TO_DISPLAY = 2;
  final List<Transaction> transactions;

  _ListOfRecentActivities({required this.transactions});

  List<Transaction> _transactionsToDisplay() {
    if (transactions.isEmpty) return [];
    if (transactions.length <= NB_ACTIVITIES_TO_DISPLAY) return transactions;
    return transactions.take(NB_ACTIVITIES_TO_DISPLAY).toList();
  }

  @override
  Widget build(BuildContext context) {
    return (_transactionsToDisplay().isEmpty)
        ? Center(child: Text(Translation.of(context).noActivity))
        : Column(
            children: [
              for (var transaction in _transactionsToDisplay())
                GestureDetector(
                  child: TransactionRow(transaction: transaction),
                  onTap: () => {
                    Navigator.pushNamed(
                      context,
                      RouteName.activity_details,
                      arguments: ActivityDetailsPageArguments(transaction: transaction, showSimilarTransactions: true),
                    ),
                  },
                ),
            ],
          );
  }
}
