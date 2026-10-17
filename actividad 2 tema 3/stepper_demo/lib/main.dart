import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(const StepperDemoApp());
}

/// Aplicación principal con soporte de internacionalización (i18n) en español e inglés.
class StepperDemoApp extends StatefulWidget {
  /// Crea la aplicación de demostración de compra de entradas.
  const StepperDemoApp({super.key});

  @override
  State<StepperDemoApp> createState() => _StepperDemoAppState();
}

class _StepperDemoAppState extends State<StepperDemoApp> {
  Locale _currentLocale = const Locale('es');

  void _setLocale(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stepper Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E40AF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      locale: _currentLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: TicketPurchaseScreen(
        currentLocale: _currentLocale,
        onLocaleChanged: _setLocale,
      ),
    );
  }
}

/// Pantalla de compra de entradas que implementa los requisitos A7.
class TicketPurchaseScreen extends StatefulWidget {
  /// Crea una pantalla de compra de entradas.
  const TicketPurchaseScreen({
    super.key,
    this.currentLocale,
    required this.onLocaleChanged,
  });

  /// Idioma seleccionado manualmente, o null si usa el del dispositivo.
  final Locale? currentLocale;

  /// Callback para alternar el idioma de la aplicación.
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<TicketPurchaseScreen> createState() => _TicketPurchaseScreenState();
}

class _TicketPurchaseScreenState extends State<TicketPurchaseScreen> {
  int _quantity = 1;
  int _rating = 4;
  final double _unitPrice = 4.50;
  final DateTime _eventDate = DateTime(2026, 10, 24, 20, 30);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final localeCode = Localizations.localeOf(context).languageCode;

    // Formateo de fecha con DateFormat localizado
    final formattedDate = DateFormat.yMMMMEEEEd(localeCode).format(_eventDate);

    // Formateo de moneda según convención de cada idioma
    final total = _unitPrice * _quantity;
    final currencyFormatter = NumberFormat.currency(
      locale: localeCode,
      symbol: '€',
      customPattern: localeCode == 'es' ? '#,##0.00 ¤' : '¤#,##0.00',
    );
    final formattedTotal = currencyFormatter.format(total);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'es', label: Text('ES')),
                ButtonSegment(value: 'en', label: Text('EN')),
              ],
              selected: {localeCode},
              onSelectionChanged: (Set<String> newSelection) {
                widget.onLocaleChanged(Locale(newSelection.first));
              },
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Insignia informativa
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoBadge(
                          label: localeCode == 'es' ? 'MÚSICA CLÁSICA' : 'CLASSICAL MUSIC',
                          icon: Icons.music_note,
                          color: theme.colorScheme.primary,
                        ),
                        InfoBadge(
                          label: localeCode == 'es' ? 'AUDITORIO' : 'AUDITORIUM',
                          icon: Icons.location_on,
                          color: Colors.teal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Título y subtítulo del evento
                    Text(
                      l10n.eventName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.eventSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Fecha del evento traducida
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 20, color: theme.colorScheme.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l10n.eventDateLabel(formattedDate),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 32),

                    // Selector de Entradas (QuantityStepper con min 1, max 8)
                    Text(
                      localeCode == 'es' ? 'Selección de entradas:' : 'Ticket selection:',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.ticketsCount(_quantity),
                              key: const Key('ticket_count_display'),
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              l10n.ticketUnitPrice,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                        QuantityStepper(
                          min: 1,
                          max: 8,
                          step: 1,
                          initialValue: _quantity,
                          semanticLabel: l10n.stepperSemanticLabel,
                          decrementTooltip: l10n.decrementTooltip,
                          incrementTooltip: l10n.incrementTooltip,
                          onChanged: (newVal) {
                            setState(() {
                              _quantity = newVal;
                            });
                          },
                          onLimitReached: (limit) {
                            if (limit == StepperLimit.max) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.maxReachedMessage),
                                  backgroundColor: Colors.deepOrange,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const Divider(height: 32),

                    // Valoración del evento con StarRating
                    Text(
                      l10n.ratingTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        StarRating(
                          initialRating: _rating,
                          semanticLabel: l10n.ratingTitle,
                          onRatingChanged: (newRating) {
                            setState(() {
                              _rating = newRating;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '($_rating / 5)',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),

                    // Precio total formateado
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              localeCode == 'es' ? 'Total a pagar' : 'Total amount',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            formattedTotal,
                            key: const Key('total_price_text'),
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Botón de confirmación de compra
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton.icon(
                        icon: const Icon(Icons.shopping_cart_checkout),
                        label: Text(
                          l10n.confirmPurchase,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                l10n.purchaseSuccess(_quantity, formattedTotal),
                              ),
                              backgroundColor: Colors.green.shade700,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
