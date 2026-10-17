// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ticket Purchase';

  @override
  String get eventName => 'Grand Spring Symphony Concert';

  @override
  String get eventSubtitle => 'Víctor Villegas Auditorium and Congress Center';

  @override
  String ticketsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString tickets',
      one: '1 ticket',
    );
    return '$_temp0';
  }

  @override
  String get ticketUnitPrice => '€4.50 per ticket';

  @override
  String totalPrice(String price) {
    return 'Total price: $price';
  }

  @override
  String eventDateLabel(String date) {
    return 'Event date: $date';
  }

  @override
  String get stepperSemanticLabel => 'Ticket quantity selector';

  @override
  String get decrementTooltip => 'Remove ticket';

  @override
  String get incrementTooltip => 'Add ticket';

  @override
  String get maxReachedMessage => 'You have reached the maximum';

  @override
  String get ratingTitle => 'Event Rating';

  @override
  String get confirmPurchase => 'Purchase tickets';

  @override
  String purchaseSuccess(num count, String price) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tickets',
      one: '1 ticket',
    );
    return 'You have purchased $_temp0 for $price!';
  }

  @override
  String get languageLabel => 'Language';
}
