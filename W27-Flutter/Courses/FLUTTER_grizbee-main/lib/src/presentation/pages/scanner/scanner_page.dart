import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grizbee/src/presentation/blocs/balance/balance_bloc.dart';
import 'package:grizbee/src/presentation/blocs/scanner/scanner_bloc.dart';
import 'package:grizbee/src/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:grizbee/src/domain/entities/transaction.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/pages/scanner/transaction_payment_modal.dart';
import 'package:grizbee/src/presentation/utils/modal_display.dart';
import 'package:grizbee/src/presentation/widgets/dialogs/failure_dialog.dart';
import 'package:grizbee/src/presentation/widgets/loaders/loader_full_page.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Future<void> _scanQR(BuildContext context) async {
    String? scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff3b30',
        Translation.of(context).cancel,
        false,
        ScanMode.QR,
      );
    } on PlatformException {
      context.read<ScannerBloc>().add(ScannerFailureEvent());
    }

    if (scanResult != null && scanResult != '-1') {
      context.read<ScannerBloc>().add(ScannerSuccessEvent(scanResult));
    } else {
      context.read<ScannerBloc>().add(ScannerAbortEvent());
    }
  }

  void _showTransactionPayment(BuildContext context, Transaction transaction) {
    ModalSheet.show(
      context: context,
      content: BlocProvider.value(
        value: BlocProvider.of<TransactionPaymentBloc>(context, listen: false),
        child: TransactionPaymentModal(transaction: transaction),
      ),
    );
  }

  void _reportScanFailure(BuildContext context) {
    showDialog(
      context: context,
      builder: (innerContext) => FailureDialog(
        dialogContext: innerContext,
        title: 'Échec du scan',
        message: 'Impossible de scanner le QR code',
      ),
    );
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen to scanner states
        BlocListener<ScannerBloc, ScannerState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case ScannerSuccess:
                context.read<TransactionPaymentBloc>().add(GetTransactionToPayEvent());
                break;

              case ScannerFailure:
                _reportScanFailure(context);
                break;
            }
          },
        ),
        // Listen to transaction states
        BlocListener<TransactionPaymentBloc, TransactionState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case TransactionToPayLoading:
              case TransactionPaymentProcessing:
                setState(() => loading = true);
                break;

              case TransactionToPayLoaded:
                setState(() => loading = false);
                _showTransactionPayment(context, (state as TransactionToPayLoaded).transaction);
                break;

              case TransactionPaymentProceeded:
                setState(() => loading = false);
                InfoSnackBar.showPaymentSnackBar(context, (state as TransactionPaymentProceeded).transaction);
                // Reload recent transactions
                context.read<BalanceBloc>().add(GetBalanceEvent());
                context.read<TransactionBloc>().add(GetTransactionsEvent());
                break;

              case TransactionToPayFailure:
                setState(() => loading = false);
                InfoSnackBar.showErrorSnackBar(context, (state as TransactionToPayFailure).message);
                break;

              case TransactionPaymentFailure:
                setState(() => loading = false);
                InfoSnackBar.showErrorSnackBar(context, (state as TransactionPaymentFailure).message);
                break;
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(Translation.of(context).scanPay)),
        body: AbsorbPointer(
          absorbing: loading,
          child: Stack(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => _scanQR(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/graphics/qrcode.png'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        Translation.of(context).launchScanner,
                        style: TextStyle(fontSize: 28, color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ),
              ),
              if (loading) LoaderFullPage(),
            ],
          ),
        ),
      ),
    );
  }
}
