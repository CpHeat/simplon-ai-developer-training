import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grizbee/src/presentation/blocs/balance/balance_bloc.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/pages/payment/fund_payment_page.dart';
import 'package:grizbee/src/presentation/utils/formatters.dart';
import 'package:grizbee/src/presentation/utils/modal_display.dart';
import 'package:grizbee/src/presentation/widgets/cards/base_card.dart';
import 'package:grizbee/src/presentation/widgets/loaders/loader_in_widget.dart';
import 'package:grizbee/src/presentation/widgets/sheets/bottom_sheets.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar_section_navigator.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BalanceBloc, BalanceState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case BalanceFailure:
            InfoSnackBar.showErrorSnackBar(context, (state as BalanceFailure).message);
            break;
        }
      },
      child: BaseCard(
          content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Translation.of(context).grizbeeBalance,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                child: Icon(Icons.more_vert),
                onTap: () => ModalSheet.show(
                  context: context,
                  content: TwoButtonsSheet(
                    title: Translation.of(context).creditAccount,
                    action: () => Navigator.pushNamed(
                      context,
                      RouteName.funds_transfer,
                      arguments: FundTransferPageArguments(
                        flowType: MoneyFlowType.deposit,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<BalanceBloc, BalanceState>(
            builder: (context, state) => _getBalanceText(context, state),
          ),
        ],
      )),
    );
  }

  Widget _getBalanceText(BuildContext context, BalanceState state) {
    switch (state.runtimeType) {
      case BalanceLoading:
      case FundsDepositProcessing:
        return LoaderInWidget();
      case BalanceLoaded:
      case FundsDepositProceeded:
        if (state.value == null) return _BalanceFailureText();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AmountFormatter.format(context, state.value!),
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    'EUR',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
            Text(Translation.of(context).available, style: TextStyle(color: Colors.grey))
          ],
        );
      case BalanceFailure:
      default:
        return _BalanceFailureText();
    }
  }
}

class _BalanceFailureText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '--,--',
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}
