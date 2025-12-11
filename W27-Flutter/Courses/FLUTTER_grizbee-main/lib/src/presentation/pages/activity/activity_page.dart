import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grizbee/src/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/pages/activity/activity_details_page.dart';
import 'package:grizbee/src/presentation/utils/modal_display.dart';
import 'package:grizbee/src/presentation/widgets/loaders/loader_full_page.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar_section_navigator.dart';
import 'package:grizbee/src/presentation/widgets/transactions/transaction_row.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    context.read<TransactionBloc>().add(GetTransactionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Translation.of(context).activity)),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case TransactionsFailure:
              InfoSnackBar.showErrorSnackBar(context, (state as TransactionsFailure).message);
              break;
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case TransactionsLoading:
              return LoaderFullPage();

            case TransactionsLoaded:
              final transactions = (state as TransactionsLoaded).transactions;
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final transaction = transactions[index];
                    return GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: TransactionRow(transaction: transaction),
                      ),
                      onTap: () => {
                        Navigator.pushNamed(
                          context,
                          RouteName.activity_details,
                          arguments: ActivityDetailsPageArguments(transaction: transaction, showSimilarTransactions: true),
                        )
                      },
                    );
                  });
            default:
              return Center(child: Text(Translation.of(context).noActivity));
          }
        },
      ),
    );
  }
}
