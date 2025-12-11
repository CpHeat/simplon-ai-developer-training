import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grizbee/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/pages/payment/fund_payment_page.dart';
import 'package:grizbee/src/presentation/utils/modal_display.dart';
import 'package:grizbee/src/presentation/widgets/contacts/contact_row.dart';
import 'package:grizbee/src/presentation/widgets/loaders/loader_full_page.dart';
import 'package:grizbee/src/presentation/widgets/sheets/bottom_sheets.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar_section_navigator.dart';

class TransferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Translation.of(context).sendAskMoney)),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ContactsLoading:
              return LoaderFullPage();

            case ContactsLoaded:
              final contacts = (state as ContactsLoaded).contacts;
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(contacts.length, (index) {
                  final contact = contacts[index];
                  return GestureDetector(
                    child: ContactRow(contact: contacts[index]),
                    onTap: () => ModalSheet.show(
                      context: context,
                      content: ThreeButtonsSheet(
                        firstTitle: Translation.of(context).send.toUpperCase(),
                        secondTitle: Translation.of(context).ask.toUpperCase(),
                        firstAction: () => {
                          Navigator.pushNamed(
                            context,
                            RouteName.funds_transfer,
                            arguments: FundTransferPageArguments(contact: contact, flowType: MoneyFlowType.pay),
                          ),
                        },
                        secondAction: () => {
                          Navigator.pushNamed(
                            context,
                            RouteName.funds_transfer,
                            arguments: FundTransferPageArguments(contact: contact, flowType: MoneyFlowType.demand),
                          )
                        },
                      ),
                    ),
                  );
                }),
              );
            default:
              return Center(child: Text(Translation.of(context).noContact));
          }
        },
      ),
    );
  }
}
