import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

void main() {
  test('ui_kit_dam exports QuantityStepper, InfoBadge, and StarRating correctly', () {
    expect(nextStepperValue(current: 0, delta: 1, min: 0, max: 10), equals(1));
    const stepper = QuantityStepper();
    expect(stepper.min, equals(0));
    expect(stepper.max, equals(10));
    expect(stepper.initialValue, equals(0));
    expect(stepper.step, equals(1));

    const badge = InfoBadge(label: 'Test');
    expect(badge.label, equals('Test'));

    const rating = StarRating();
    expect(rating.maxRating, equals(5));
  });
}
