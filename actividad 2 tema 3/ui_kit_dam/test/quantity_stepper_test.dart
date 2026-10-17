import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

void main() {
  group('A4.1 - Pruebas unitarias de la función pura nextStepperValue', () {
    test('Incremento estándar dentro del rango válido', () {
      final result = nextStepperValue(
        current: 3,
        delta: 1,
        min: 0,
        max: 10,
      );
      expect(result, equals(4));
    });

    test('Decremento estándar dentro del rango válido', () {
      final result = nextStepperValue(
        current: 7,
        delta: -1,
        min: 0,
        max: 10,
      );
      expect(result, equals(6));
    });

    test('Límite superior: no supera max al sumar cuando ya está en el máximo', () {
      final result = nextStepperValue(
        current: 10,
        delta: 1,
        min: 0,
        max: 10,
      );
      expect(result, equals(10));
    });

    test('Límite superior: salto con step mayor que el margen restante se ajusta a max', () {
      final result = nextStepperValue(
        current: 9,
        delta: 5,
        min: 0,
        max: 10,
      );
      expect(result, equals(10));
    });

    test('Límite inferior: no desciende de min al restar cuando ya está en el mínimo', () {
      final result = nextStepperValue(
        current: 0,
        delta: -1,
        min: 0,
        max: 10,
      );
      expect(result, equals(0));
    });

    test('Límite inferior: salto con step negativo mayor que el margen se ajusta a min', () {
      final result = nextStepperValue(
        current: 2,
        delta: -5,
        min: 0,
        max: 10,
      );
      expect(result, equals(0));
    });
  });

  group('A4.2 - Pruebas de widget de QuantityStepper', () {
    testWidgets('Sumar muestra el nuevo valor en pantalla y emite onChanged', (tester) async {
      int? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 5,
                initialValue: 0,
                onChanged: (val) => changedValue = val,
              ),
            ),
          ),
        ),
      );

      expect(find.text('0'), findsOneWidget);
      expect(changedValue, isNull);

      final incrementFinder = find.byKey(const Key('stepper_increment_button'));
      expect(incrementFinder, findsOneWidget);

      await tester.tap(incrementFinder);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(changedValue, equals(1));

      await tester.tap(incrementFinder);
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
      expect(changedValue, equals(2));
    });

    testWidgets('El botón − está desactivado en el mínimo', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 10,
                initialValue: 0,
              ),
            ),
          ),
        ),
      );

      final decrementButton = tester.widget<IconButton>(
        find.byKey(const Key('stepper_decrement_button')),
      );

      // En Flutter, un IconButton desactivado tiene su callback onPressed a null
      expect(decrementButton.onPressed, isNull);

      final incrementButton = tester.widget<IconButton>(
        find.byKey(const Key('stepper_increment_button')),
      );
      expect(incrementButton.onPressed, isNotNull);
    });

    testWidgets('El botón + está desactivado en el máximo', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 10,
                initialValue: 10,
              ),
            ),
          ),
        ),
      );

      final incrementButton = tester.widget<IconButton>(
        find.byKey(const Key('stepper_increment_button')),
      );
      expect(incrementButton.onPressed, isNull);

      final decrementButton = tester.widget<IconButton>(
        find.byKey(const Key('stepper_decrement_button')),
      );
      expect(decrementButton.onPressed, isNotNull);
    });

    testWidgets('onLimitReached recibe StepperLimit.max al alcanzar el límite superior', (tester) async {
      StepperLimit? limitReceived;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 2,
                initialValue: 1,
                onLimitReached: (limit) => limitReceived = limit,
              ),
            ),
          ),
        ),
      );

      expect(limitReceived, isNull);

      final incrementFinder = find.byKey(const Key('stepper_increment_button'));
      await tester.tap(incrementFinder);
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
      expect(limitReceived, equals(StepperLimit.max));
    });

    testWidgets('onLimitReached recibe StepperLimit.min al alcanzar el límite inferior', (tester) async {
      StepperLimit? limitReceived;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 2,
                initialValue: 1,
                onLimitReached: (limit) => limitReceived = limit,
              ),
            ),
          ),
        ),
      );

      final decrementFinder = find.byKey(const Key('stepper_decrement_button'));
      await tester.tap(decrementFinder);
      await tester.pump();

      expect(find.text('0'), findsOneWidget);
      expect(limitReceived, equals(StepperLimit.min));
    });

    testWidgets('A3.5 - Muestra SnackBar con "Has llegado al máximo" al alcanzar el límite', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Center(
                  child: QuantityStepper(
                    min: 0,
                    max: 3,
                    initialValue: 2,
                    onLimitReached: (limit) {
                      if (limit == StepperLimit.max) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Has llegado al máximo'),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Has llegado al máximo'), findsNothing);

      final incrementFinder = find.byKey(const Key('stepper_increment_button'));
      await tester.tap(incrementFinder);
      await tester.pump(); // Renderiza el frame
      await tester.pump(const Duration(milliseconds: 100)); // Anima el SnackBar

      expect(find.text('Has llegado al máximo'), findsOneWidget);
    });

    testWidgets('didUpdateWidget reajusta el valor si min o max cambian', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 10,
                initialValue: 8,
              ),
            ),
          ),
        ),
      );

      expect(find.text('8'), findsOneWidget);

      // Reconstruimos con max menor que el valor actual
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 5,
                initialValue: 2,
              ),
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });
  });

  group('A4.3 - Prueba golden de QuantityStepper', () {
    testWidgets('Prueba golden con valor 5', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          home: const Scaffold(
            body: Center(
              child: RepaintBoundary(
                child: QuantityStepper(
                  min: 0,
                  max: 10,
                  initialValue: 5,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(QuantityStepper),
        matchesGoldenFile('goldens/quantity_stepper_val5.png'),
      );
    });
  });

  group('Pruebas adicionales de componentes auxiliares', () {
    testWidgets('InfoBadge renderiza etiqueta e icono correctamente', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: InfoBadge(
                label: 'En stock',
                icon: Icons.check,
                color: Colors.green,
              ),
            ),
          ),
        ),
      );

      expect(find.text('En stock'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('StarRating permite seleccionar valoración y emite cambios', (tester) async {
      int? selected;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: StarRating(
                initialRating: 2,
                maxRating: 5,
                onRatingChanged: (rating) => selected = rating,
              ),
            ),
          ),
        ),
      );

      final star4 = find.byKey(const Key('star_rating_4'));
      expect(star4, findsOneWidget);
      await tester.tap(star4);
      await tester.pump();

      expect(selected, equals(4));
    });
  });
}
