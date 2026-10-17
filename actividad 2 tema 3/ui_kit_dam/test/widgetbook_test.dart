import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

void main() {
  testWidgets('Captura de catálogo visual de QuantityStepper', (tester) async {
    tester.view.physicalSize = const Size(600, 450);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Widgetbook - QuantityStepper'),
            backgroundColor: Colors.indigo.shade50,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Caso de uso: "Por defecto"',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                const QuantityStepper(),
                const Divider(height: 32),
                const Text(
                  'Caso de uso: "Configurable" (min: 2, max: 8, step: 2, initial: 4)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                const QuantityStepper(
                  min: 2,
                  max: 8,
                  step: 2,
                  initialValue: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('../../memoria_assets/widgetbook_catalog.png'),
    );
  });
}
