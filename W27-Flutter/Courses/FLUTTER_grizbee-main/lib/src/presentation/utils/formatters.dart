import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

abstract class AmountFormatter {
  static String format(BuildContext context, double amount) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'fr':
        return NumberFormat("#,##0.00", "fr_FR").format(amount);
      default:
        return NumberFormat("#,##0.00", "en_US").format(amount);
    }
  }
}

abstract class DateFormatter {
  static String format(BuildContext context, DateTime date) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'fr':
        return DateFormat.yMMMd('fr_FR').format(date);
      default:
        return DateFormat.yMMMd('en_US').format(date);
    }
  }
}
