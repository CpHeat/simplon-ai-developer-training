import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grizbee/src/presentation/blocs/balance/balance_bloc.dart';
import 'package:grizbee/src/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/utils/modal_display.dart';
import 'package:grizbee/src/presentation/widgets/avatars/contact_avatar.dart';
import 'package:grizbee/src/presentation/widgets/dialogs/failure_dialog.dart';
import 'package:grizbee/src/presentation/widgets/loaders/loader_full_page.dart';
import 'package:grizbee/src/presentation/widgets/sheets/bottom_sheets.dart';

enum MoneyFlowType { deposit, pay, demand }

class FundTransferPageArguments {
  final Contact? contact;
  final MoneyFlowType flowType;

  FundTransferPageArguments({this.contact, required this.flowType});
}

class FundsTransferPage extends StatefulWidget {
  final FundTransferPageArguments args;

  FundsTransferPage({required this.args});

  @override
  _FundsTransferPageState createState() => _FundsTransferPageState();
}

class _FundsTransferPageState extends State<FundsTransferPage> {
  final _textEditingController = TextEditingController();
  bool loading = false;

  Widget _getAvatar() {
    final double radiusSize = 40;
    String contactPicture = widget.args.contact?.picture ?? '';
    switch (widget.args.flowType) {
      case MoneyFlowType.deposit:
        return CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(
              CupertinoIcons.cloud_upload,
              size: 50,
              color: Colors.white,
            ),
            radius: radiusSize);
      case MoneyFlowType.pay:
        return ContactAvatar.payment(picture: contactPicture, iconSize: 30, avatarRadius: radiusSize);
      case MoneyFlowType.demand:
        return CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(
              CupertinoIcons.cloud_download,
              size: 50,
              color: Colors.white,
            ),
            radius: radiusSize);
    }
  }

  String _getMessage(BuildContext context) {
    switch (widget.args.flowType) {
      case MoneyFlowType.deposit:
        return Translation.of(context).iWantToCredit;
      case MoneyFlowType.pay:
        return Translation.of(context).iWantToSend;
      case MoneyFlowType.demand:
        return Translation.of(context).askToContact;
    }
  }

  String _getTitle(BuildContext context) {
    switch (widget.args.flowType) {
      case MoneyFlowType.deposit:
        return Translation.of(context).toCredit;
      case MoneyFlowType.pay:
      case MoneyFlowType.demand:
        return widget.args.contact?.name ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final contact = widget.args.contact;
    final flowType = widget.args.flowType;

    return MultiBlocListener(
      listeners: [
        BlocListener<TransactionContactBloc, TransactionState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case ContactPaymentProcessing:
              case MoneyRequestProcessing:
                setState(() => loading = true);
                break;

              case ContactPaymentProceeded:
                Navigator.pop(context);
                InfoSnackBar.showPaymentSnackBar(context, (state as ContactPaymentProceeded).transaction);
                // Reload some info
                context.read<BalanceBloc>().add(GetBalanceEvent());
                context.read<TransactionBloc>().add(GetTransactionsEvent());
                break;

              case MoneyRequestProceeded:
                Navigator.pop(context);
                InfoSnackBar.showFundsRequestSnackBar(context, (state as MoneyRequestProceeded).amount);
                break;

              case ContactPaymentFailure:
                Navigator.pop(context);
                InfoSnackBar.showErrorSnackBar(context, (state as ContactPaymentFailure).message);
                break;
              case MoneyRequestFailure:
                Navigator.pop(context);
                InfoSnackBar.showErrorSnackBar(context, (state as MoneyRequestFailure).message);
                break;
            }
          },
        ),
        BlocListener<BalanceBloc, BalanceState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case FundsDepositProcessing:
                setState(() => loading = true);
                break;

              case FundsDepositProceeded:
                Navigator.pop(context);
                InfoSnackBar.showFundsDepositSnackBar(context);
                // Reload some info
                context.read<BalanceBloc>().add(GetBalanceEvent());
                break;

              case FundsDepositFailure:
                Navigator.pop(context);
                InfoSnackBar.showErrorSnackBar(context, (state as FundsDepositFailure).message);
                // Reload some info
                context.read<BalanceBloc>().add(GetBalanceEvent());
                break;
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(_getTitle(context)),
        ),
        body: AbsorbPointer(
          absorbing: loading,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    _getAvatar(),
                    SizedBox(height: 20),
                    Text(_getMessage(context), style: TextStyle(fontSize: 30, color: Colors.grey), textAlign: TextAlign.center),
                    SizedBox(height: 20),
                    TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      style: TextStyle(fontSize: 80),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      maxLength: 7,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey.shade200),
                        hintText: '00,00',
                        counterText: '',
                      ),
                      onSubmitted: (context) => _handleEnteredAMount(flowType, contact, _textEditingController.text),
                    ),
                  ],
                ),
              ),
              if (loading) LoaderFullPage()
            ],
          ),
        ),
      ),
    );
  }

  void _handleEnteredAMount(MoneyFlowType flowType, Contact? contact, String enteredText) {
    final amount = double.tryParse(enteredText.replaceFirst(RegExp(','), '.'));
    if (amount == null || amount <= 0) {
      // Bad entered value
      showDialog(
        context: context,
        builder: (innerContext) => FailureDialog(
          dialogContext: innerContext,
          title: Translation.of(context).entryError,
          message: Translation.of(context).entryErrorAmount,
        ),
      );
    } else {
      // - Ask for confirmation
      // - Request bloc to update the balance
      final actionAfterConfirmation = () {
        switch (flowType) {
          case MoneyFlowType.deposit:
            context.read<BalanceBloc>().add(DepositFundsEvent(amount));
            break;
          case MoneyFlowType.pay:
            context.read<TransactionContactBloc>().add(PayContactEvent(contact!, amount));
            break;
          case MoneyFlowType.demand:
            context.read<TransactionContactBloc>().add(RequestFundsEvent(contact!, amount));
            break;
        }
      };
      ModalSheet.show(
        context: context,
        content: TwoButtonsSheet(
          title: Translation.of(context).confirmAmount,
          action: actionAfterConfirmation,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textEditingController.dispose();
    super.dispose();
  }
}
