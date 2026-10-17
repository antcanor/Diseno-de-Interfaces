import 'package:flutter/material.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';
import 'package:widgetbook/widgetbook.dart';

/// Punto de entrada del catálogo Widgetbook para los componentes de [ui_kit_dam].
void main() {
  runApp(const WidgetbookApp());
}

/// Aplicación principal de Widgetbook que muestra el catálogo de componentes.
class WidgetbookApp extends StatelessWidget {
  /// Crea una instancia del catálogo [WidgetbookApp].
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookComponent(
          name: 'QuantityStepper',
          useCases: [
            WidgetbookUseCase(
              name: 'Por defecto',
              builder: (context) => const Scaffold(
                body: Center(
                  child: QuantityStepper(),
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'Configurable',
              builder: (context) {
                final min = context.knobs.intOrNull.input(
                      label: 'Min',
                      initialValue: 0,
                    ) ??
                    0;
                final max = context.knobs.intOrNull.input(
                      label: 'Max',
                      initialValue: 10,
                    ) ??
                    10;
                final step = context.knobs.intOrNull.input(
                      label: 'Step',
                      initialValue: 1,
                    ) ??
                    1;

                final safeMin = min < max ? min : max - 1;
                final safeStep = step > 0 ? step : 1;

                return Scaffold(
                  body: Center(
                    child: QuantityStepper(
                      key: ValueKey('$safeMin-$max-$safeStep'),
                      min: safeMin,
                      max: max,
                      step: safeStep,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
