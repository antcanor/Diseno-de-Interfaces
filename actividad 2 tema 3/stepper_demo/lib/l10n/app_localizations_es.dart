// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Compra de Entradas';

  @override
  String get eventName => 'Gran Concierto Sinfónico de Primavera';

  @override
  String get eventSubtitle => 'Auditorio y Centro de Congresos Víctor Villegas';

  @override
  String ticketsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString entradas',
      one: '1 entrada',
    );
    return '$_temp0';
  }

  @override
  String get ticketUnitPrice => '4,50 € por entrada';

  @override
  String totalPrice(String price) {
    return 'Precio total: $price';
  }

  @override
  String eventDateLabel(String date) {
    return 'Fecha del evento: $date';
  }

  @override
  String get stepperSemanticLabel => 'Selector de cantidad de entradas';

  @override
  String get decrementTooltip => 'Restar entrada';

  @override
  String get incrementTooltip => 'Sumar entrada';

  @override
  String get maxReachedMessage => 'Has llegado al máximo';

  @override
  String get ratingTitle => 'Valoración del evento';

  @override
  String get confirmPurchase => 'Comprar entradas';

  @override
  String purchaseSuccess(num count, String price) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas',
      one: '1 entrada',
    );
    return '¡Has comprado $_temp0 por $price!';
  }

  @override
  String get languageLabel => 'Idioma';
}
