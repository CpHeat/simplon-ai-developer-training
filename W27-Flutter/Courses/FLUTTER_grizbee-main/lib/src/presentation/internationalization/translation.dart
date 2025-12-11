import 'package:flutter/material.dart';

class Translation {
  Translation(this.locale);

  final Locale locale;

  static Translation of(BuildContext context) =>
      Localizations.of<Translation>(context, Translation)!;

  // Make english the default language
  Map<String, String> get stringValues {
    if (locale.languageCode == 'fr')
      return _localizedValues[locale.languageCode]!;
    return _localizedValues['en']!;
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'fr': {
      'money_request_done': 'Demande d\'argent effectué',
      'account_funded': 'Compte réapprovisionné',
      'payment_done': 'Paiement effectué',
      'grizbee_balance': 'Solde GrizBee',
      'credit_account': 'Créditer mon compte',
      'available': 'Disponible',
      'activity': 'Activité',
      'no_activity': 'Aucune activité',
      'recent_activity': 'Activité récente',
      'your_activity_with': 'Votre activité avec',
      'see_all_activities': 'Voir toute l\'activité',
      'cancel': 'Annuler',
      'amount': 'Montant',
      'delivery': 'Livraison',
      'tax': 'Taxe',
      'subtotal': 'Sous-total',
      'fee': 'Frais',
      'total': 'Total',
      'you_and': 'Vous et',
      'to_contact': 'Contacter',
      'type_of_transaction': 'Type de transaction',
      'similar_transactions': 'Transactions similaires',
      'details_of_the_transaction': 'Détails de la transaction',
      'top_up_prepaid_phones': 'Recharger des téléphones prépayés',
      'accept_qr_code_payment': 'Accepter des paiements par code QR',
      'send_bank_transfers_or_cash':
          'Envoyer des virements bancaires ou des espèces',
      'create_pot': 'Créer une cagnotte',
      'support_association': 'Soutenir une association',
      'no_additional_transactions': 'Aucune transaction supplémentaire',
      'scan_pay': 'Scanner - Payer',
      'launch_scanner': 'Lancer le scanner',
      'send_ask_money': 'Envoyer/Demander de l\'argent',
      'send': 'Envoyer',
      'ask': 'Demander',
      'no_contact': 'Pas de contact',
      'pay_this_contact': 'Payer à ce contact : ',
      'validate_payment': 'Valider le paiement',
      'i_want_to_credit': 'Je souhaite créditer mon compte de',
      'i_want_to_send': 'Je souhaite envoyer à ce contact',
      'ask_to_contact': 'Demander à ce contact',
      'to_credit': 'Créditer',
      'entry_error': 'Erreur de saisie',
      'entry_error_amount':
          'Le montant saisi n\'est pas correct.\nIl doit être de la forme 00.00 ou 00,00',
      'confirm_amount': 'Je confirme le montant',
      'feature_availability': 'Fonctionnalité bientôt disponible',
      'thanks_for_patience': 'Merci de votre patience ;-)',
      'close': 'Fermer',
      'send_money_again': 'Renvoyer de l\'argent à :',
      'info': 'Infos',
      'scanner': 'Scanner',
      'transfer': 'Transférer',
      'more': 'Plus',
      'transaction_purchase': 'Achat',
      'transaction_auto_payment': 'Paiement automatique',
      'transaction_received': 'Argent reçu',
      'transaction_send': 'Argent envoyé',
      'transaction_other': 'Autre transaction',
      'you_have_paid': 'Vous avez payé ',
      'you_have_received': 'Vous avez reçu ',
      'to': 'à',
      'from': 'de',
    },
    'en': {
      'money_request_done': 'Money request done',
      'account_funded': 'Account funded',
      'payment_done': 'Payment done',
      'grizbee_balance': 'GrizBee balance',
      'credit_account': 'Credit my account',
      'available': 'Available',
      'activity': 'Activity',
      'no_activity': 'No activity',
      'recent_activity': 'Recent activity',
      'your_activity_with': 'Your activity with',
      'see_all_activities': 'See all activities',
      'cancel': 'Cancel',
      'amount': 'Amount',
      'delivery': 'Delivery',
      'tax': 'Tax',
      'subtotal': 'Sub-total',
      'fee': 'Fee',
      'total': 'Total',
      'you_and': 'You and',
      'to_contact': 'Contact',
      'type_of_transaction': 'Type of transaction',
      'similar_transactions': 'Similar transactions',
      'details_of_the_transaction': 'Details of transaction',
      'top_up_prepaid_phones': 'Top up prepaid phones',
      'accept_qr_code_payment': 'Accept QR code paiement',
      'send_bank_transfers_or_cash': 'Send bank transfers or cash',
      'create_pot': 'Create a pot',
      'support_association': 'Support an association',
      'no_additional_transactions': 'No additional transactions',
      'scan_pay': 'Scan - Pay',
      'launch_scanner': 'Launch scanner',
      'send_ask_money': 'Send/Ask for money',
      'send': 'Send',
      'ask': 'Ask',
      'no_contact': 'No contact',
      'pay_this_contact': 'Pay this contact : ',
      'validate_payment': 'Validate payment',
      'i_want_to_credit': 'I want to credit my account with',
      'i_want_to_send': 'I want to send to this contact',
      'ask_to_contact': 'Ask to this contact',
      'to_credit': 'Credit',
      'entry_error': 'Entry error',
      'entry_error_amount':
          'Entered amount is not correct.\nIt must fit this format : 00.00 or 00,00',
      'confirm_amount': 'Confirm the amount',
      'feature_availability': 'Feature coming soon',
      'thanks_for_patience': 'Thanks for your patience ;-)',
      'close': 'Close',
      'send_money_again': 'Send money again to :',
      'info': 'Infos',
      'scanner': 'Scan',
      'transfer': 'Transfer',
      'more': 'More',
      'transaction_purchase': 'Purchase',
      'transaction_auto_payment': 'Automatic payment',
      'transaction_received': 'Received money',
      'transaction_send': 'Sent money',
      'transaction_other': 'Other transaction',
      'you_have_paid': 'You have paid ',
      'you_have_received': 'You have received ',
      'to': 'to',
      'from': 'from',
    },
  };

  String get youHavePaid => stringValues['you_have_paid']!;

  String get youHaveReceived => stringValues['you_have_received']!;

  String get to => stringValues['to']!;

  String get from => stringValues['from']!;

  String get purchase => stringValues['transaction_purchase']!;

  String get autoPayment => stringValues['transaction_auto_payment']!;

  String get receivedMoney => stringValues['transaction_received']!;

  String get sentMoney => stringValues['transaction_send']!;

  String get otherTransaction => stringValues['transaction_other']!;

  String get info => stringValues['info']!;

  String get scanner => stringValues['scanner']!;

  String get transfer => stringValues['transfer']!;

  String get more => stringValues['more']!;

  String get moneyRequestDone => stringValues['money_request_done']!;

  String get accountFunded => stringValues['account_funded']!;

  String get paymentDone => stringValues['payment_done']!;

  String get grizbeeBalance => stringValues['grizbee_balance']!;

  String get available => stringValues['available']!;

  String get creditAccount => stringValues['credit_account']!;

  String get activity => stringValues['activity']!;

  String get noActivity => stringValues['no_activity']!;

  String get recentActivity => stringValues['recent_activity']!;

  String get yourActivityWith => stringValues['your_activity_with']!;

  String get seeAllActivities => stringValues['see_all_activities']!;

  String get cancel => stringValues['cancel']!;

  String get amount => stringValues['amount']!;

  String get delivery => stringValues['delivery']!;

  String get tax => stringValues['tax']!;

  String get subtotal => stringValues['subtotal']!;

  String get fee => stringValues['fee']!;

  String get total => stringValues['total']!;

  String get youAnd => stringValues['you_and']!;

  String get toContact => stringValues['to_contact']!;

  String get typeOfTransaction => stringValues['type_of_transaction']!;

  String get similarTransactions => stringValues['similar_transactions']!;

  String get detailsOfTransaction =>
      stringValues['details_of_the_transaction']!;

  String get toUpPrepaidPhones => stringValues['top_up_prepaid_phones']!;

  String get acceptQRCodePayment => stringValues['accept_qr_code_payment']!;

  String get sendBankTransfersOrCash =>
      stringValues['send_bank_transfers_or_cash']!;

  String get createPot => stringValues['create_pot']!;

  String get supportAssociation => stringValues['support_association']!;

  String get noAdditionalTransactions =>
      stringValues['no_additional_transactions']!;

  String get scanPay => stringValues['scan_pay']!;

  String get launchScanner => stringValues['launch_scanner']!;

  String get sendAskMoney => stringValues['send_ask_money']!;

  String get send => stringValues['send']!;

  String get ask => stringValues['ask']!;

  String get noContact => stringValues['no_contact']!;

  String get payThisContact => stringValues['pay_this_contact']!;

  String get validatePayment => stringValues['validate_payment']!;

  String get iWantToCredit => stringValues['i_want_to_credit']!;

  String get iWantToSend => stringValues['i_want_to_send']!;

  String get askToContact => stringValues['ask_to_contact']!;

  String get toCredit => stringValues['to_credit']!;

  String get entryError => stringValues['entry_error']!;

  String get entryErrorAmount => stringValues['entry_error_amount']!;

  String get confirmAmount => stringValues['confirm_amount']!;

  String get featureAvailability => stringValues['feature_availability']!;

  String get thanksForPatience => stringValues['thanks_for_patience']!;

  String get close => stringValues['close']!;

  String get sendMoneyAgain => stringValues['send_money_again']!;
}
