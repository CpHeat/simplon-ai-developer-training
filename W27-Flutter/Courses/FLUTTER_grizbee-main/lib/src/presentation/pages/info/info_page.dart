import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grizbee/src/presentation/blocs/balance/balance_bloc.dart';
import 'package:grizbee/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:grizbee/src/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/widgets/cards/balance_card.dart';
import 'package:grizbee/src/presentation/widgets/cards/recent_activity_card.dart';
import 'package:grizbee/src/presentation/widgets/contacts/contact_list_card.dart';
import 'package:intl/date_symbol_data_local.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  void initState() {
    _requestInfos();
    super.initState();
  }

  void _requestInfos() {
    context.read<BalanceBloc>().add(GetBalanceEvent());
    context.read<TransactionBloc>().add(GetTransactionsEvent());
    context.read<ContactBloc>().add(GetContactsEvent());
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        title: Text(Translation.of(context).info),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.grey.shade100,
        child: RefreshIndicator(
          onRefresh: () async {
            _requestInfos();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Contact list
                ContactListCard(),
                // Card for account balance
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Card for balance
                      BalanceCard(),
                      // Card for recent activity
                      RecentActivityCard(),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
