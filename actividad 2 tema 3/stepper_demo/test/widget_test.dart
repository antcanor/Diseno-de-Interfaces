import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stepper_demo/main.dart';

void main() {
  testWidgets('Carga inicial de stepper_demo en español con valores por defecto', (tester) async {
    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    // Verificamos elementos traducidos en español (idioma base)
    expect(find.text('Compra de Entradas'), findsOneWidget);
    expect(find.text('Gran Concierto Sinfónico de Primavera'), findsOneWidget);
    expect(find.text('1 entrada'), findsOneWidget);
    expect(find.text('4,50 € por entrada'), findsOneWidget);
    expect(find.text('4,50 €'), findsOneWidget);

    // Botón de restar debe estar deshabilitado porque initialValue = 1 = min
    final decrementBtn = tester.widget<IconButton>(
      find.byKey(const Key('stepper_decrement_button')),
    );
    expect(decrementBtn.onPressed, isNull);
  });

  testWidgets('Incrementar entradas actualiza el plural y el total en euros', (tester) async {
    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    final incrementBtn = find.byKey(const Key('stepper_increment_button'));

    // Pulsamos una vez: pasa a 2
    await tester.tap(incrementBtn);
    await tester.pumpAndSettle();

    expect(find.text('2 entradas'), findsOneWidget);
    expect(find.text('9,00 €'), findsOneWidget);

    // Pulsamos otra vez: pasa a 3
    await tester.tap(incrementBtn);
    await tester.pumpAndSettle();

    expect(find.text('3 entradas'), findsOneWidget);
    expect(find.text('13,50 €'), findsOneWidget);
  });

  testWidgets('Alcanzar el límite de 8 entradas muestra SnackBar de límite', (tester) async {
    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    final incrementBtn = find.byKey(const Key('stepper_increment_button'));

    // Subimos de 1 a 8 entradas
    for (int i = 1; i < 8; i++) {
      await tester.tap(incrementBtn);
      await tester.pumpAndSettle();
    }

    expect(find.text('8 entradas'), findsOneWidget);
    expect(find.text('36,00 €'), findsOneWidget);
    expect(find.text('Has llegado al máximo'), findsOneWidget);

    // En 8, el botón de incremento debe estar deshabilitado
    final incrementWidget = tester.widget<IconButton>(incrementBtn);
    expect(incrementWidget.onPressed, isNull);
  });

  testWidgets('Cambiar a inglés actualiza textos, plurales y formato de moneda', (tester) async {
    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    // Pulsamos el selector de idioma 'EN'
    final enSegment = find.text('EN');
    expect(enSegment, findsOneWidget);
    await tester.tap(enSegment);
    await tester.pumpAndSettle();

    // Textos en inglés
    expect(find.text('Ticket Purchase'), findsOneWidget);
    expect(find.text('Grand Spring Symphony Concert'), findsOneWidget);
    expect(find.text('1 ticket'), findsOneWidget);
    expect(find.text('€4.50 per ticket'), findsOneWidget);
    expect(find.text('€4.50'), findsOneWidget);

    // Incrementamos en inglés
    final incrementBtn = find.byKey(const Key('stepper_increment_button'));
    await tester.tap(incrementBtn);
    await tester.pumpAndSettle();

    expect(find.text('2 tickets'), findsOneWidget);
    expect(find.text('€9.00'), findsOneWidget);
  });

  testWidgets('Interacción con StarRating actualiza la puntuación visual', (tester) async {
    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    expect(find.text('(4 / 5)'), findsOneWidget);

    // Seleccionamos 5 estrellas
    final star5 = find.byKey(const Key('star_rating_5'));
    await tester.tap(star5);
    await tester.pumpAndSettle();

    expect(find.text('(5 / 5)'), findsOneWidget);
  });
}
