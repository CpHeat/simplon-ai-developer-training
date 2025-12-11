import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grizbee/src/data/datasources/mock_contacts.dart';
import 'package:grizbee/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/pages/payment/fund_payment_page.dart';
import 'package:grizbee/src/presentation/utils/modal_display.dart';
import 'package:grizbee/src/presentation/widgets/avatars/contact_avatar.dart';
import 'package:grizbee/src/presentation/widgets/loaders/loader_in_widget.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar_section_navigator.dart';

// This widget provides a horizontal for list of contacts
// When a contact is selected, a navigation occurs to a page where we can send money to the selected contact
class ContactListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactBloc, ContactState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case GetContactsFailure:
            InfoSnackBar.showErrorSnackBar(context, (state as GetContactsFailure).message);
            break;
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ContactsLoading:
            return Padding(
              padding: EdgeInsets.all(20),
              child: LoaderInWidget(),
            );

          case ContactsLoaded:
            final contacts = (state as ContactsLoaded).contacts;
            return contacts.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          Translation.of(context).sendMoneyAgain,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: remoteContacts.length,
                          itemBuilder: (BuildContext context, int index) => Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: _AvatarContactRow(contact: remoteContacts[index]),
                              onTap: () => Navigator.pushNamed(
                                context,
                                RouteName.funds_transfer,
                                arguments: FundTransferPageArguments(
                                  contact: remoteContacts[index],
                                  flowType: MoneyFlowType.pay,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink();

          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}

class _AvatarContactRow extends StatelessWidget {
  final Contact contact;

  _AvatarContactRow({required this.contact});

  @override
  Widget build(BuildContext context) {
    String contactPicture = contact.picture ?? '';
    return Column(
      children: [
        ContactAvatar(picture: contactPicture),
        SizedBox(height: 10),
        Text(contact.name, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
