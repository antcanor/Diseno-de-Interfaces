import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stepper_demo/main.dart';

void main() {
  testWidgets('Generar capturas de la aplicación en español e inglés', (tester) async {
    tester.view.physicalSize = const Size(540, 960);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // 1. Captura en español con 3 entradas seleccionadas
    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    final incrementBtn = find.byKey(const Key('stepper_increment_button'));
    await tester.tap(incrementBtn); // 2
    await tester.pumpAndSettle();
    await tester.tap(incrementBtn); // 3
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(StepperDemoApp),
      matchesGoldenFile('../../memoria_assets/app_screenshot_es.png'),
    );

    // 2. Captura en inglés con 5 entradas seleccionadas y 5 estrellas
    final enSegment = find.text('EN');
    await tester.tap(enSegment);
    await tester.pumpAndSettle();

    await tester.tap(incrementBtn); // 4
    await tester.pumpAndSettle();
    await tester.tap(incrementBtn); // 5
    await tester.pumpAndSettle();

    final star5 = find.byKey(const Key('star_rating_5'));
    await tester.tap(star5);
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(StepperDemoApp),
      matchesGoldenFile('../../memoria_assets/app_screenshot_en.png'),
    );

    // 3. Captura con límite máximo alcanzado (8 entradas) y SnackBar
    for (int i = 5; i < 8; i++) {
      await tester.tap(incrementBtn);
      await tester.pumpAndSettle();
    }

    await expectLater(
      find.byType(StepperDemoApp),
      matchesGoldenFile('../../memoria_assets/app_screenshot_limit_reached.png'),
    );
  });
}
