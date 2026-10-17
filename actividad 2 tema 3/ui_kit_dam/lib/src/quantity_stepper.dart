import 'package:flutter/material.dart';

/// Calcula de forma pura el siguiente valor de un contador paso a paso,
/// asegurando que el resultado permanezca siempre dentro de los límites
/// definidos por [min] y [max].
///
/// * [current]: Valor actual del contador.
/// * [delta]: Variación que se desea aplicar (positiva para sumar, negativa para restar).
/// * [min]: Límite mínimo permitido.
/// * [max]: Límite máximo permitido.
///
/// Retorna el valor resultante ajustado al rango `[min, max]`.
int nextStepperValue({
  required int current,
  required int delta,
  required int min,
  required int max,
}) {
  final next = current + delta;
  if (next < min) return min;
  if (next > max) return max;
  return next;
}

/// Límites que puede alcanzar el componente [QuantityStepper].
enum StepperLimit {
  /// Límite inferior o valor mínimo permitido.
  min,

  /// Límite superior o valor máximo permitido.
  max,
}

/// Firma de callback invocada cuando [QuantityStepper] alcanza un límite ([min] o [max]).
typedef LimitReached = void Function(StepperLimit limit);

/// Un componente interactivo para seleccionar cantidades numéricas enteras
/// mediante botones de incremento y decremento.
///
/// Garantiza que el valor nunca rebase los límites [min] y [max], incluso en
/// entornos de producción (release). Deshabilita los botones al alcanzar los topes
/// y notifica mediante [onChanged] y [onLimitReached].
///
/// Ejemplo de uso:
/// ```dart
/// QuantityStepper(
///   min: 1,
///   max: 10,
///   step: 1,
///   initialValue: 1,
///   onChanged: (value) => print('Nuevo valor: $value'),
///   onLimitReached: (limit) {
///     if (limit == StepperLimit.max) {
///       print('Alcanzado el valor máximo');
///     }
///   },
/// )
/// ```
class QuantityStepper extends StatefulWidget {
  /// Crea una instancia de [QuantityStepper].
  ///
  /// * [min] debe ser estrictamente menor que [max].
  /// * [step] debe ser mayor que cero.
  /// * [initialValue], de proporcionarse, debe situarse en el intervalo `[min, max]`.
  const QuantityStepper({
    super.key,
    this.min = 0,
    this.max = 10,
    this.step = 1,
    int? initialValue,
    this.onChanged,
    this.onLimitReached,
    this.semanticLabel = 'Cantidad',
    this.decrementTooltip = 'Restar',
    this.incrementTooltip = 'Sumar',
  })  : initialValue = initialValue ?? min,
        assert(min < max, 'min debe ser menor que max'),
        assert(step > 0, 'step debe ser mayor que 0'),
        assert(
          (initialValue ?? min) >= min && (initialValue ?? min) <= max,
          'initialValue debe estar entre min y max',
        );

  /// Límite mínimo permitido. Por defecto es 0.
  final int min;

  /// Límite máximo permitido. Por defecto es 10.
  final int max;

  /// Incremento o decremento aplicado en cada pulsación. Por defecto es 1.
  final int step;

  /// Valor inicial con el que comienza el contador.
  /// Si no se especifica, toma por defecto el valor de [min].
  final int initialValue;

  /// Callback emitido cada vez que el valor numérico cambia.
  final ValueChanged<int>? onChanged;

  /// Callback emitido cuando el contador alcanza [StepperLimit.min] o [StepperLimit.max].
  final LimitReached? onLimitReached;

  /// Etiqueta de accesibilidad para lectores de pantalla. Por defecto 'Cantidad'.
  final String semanticLabel;

  /// Texto del tooltip y ayuda semántica para el botón de restar. Por defecto 'Restar'.
  final String decrementTooltip;

  /// Texto del tooltip y ayuda semántica para el botón de sumar. Por defecto 'Sumar'.
  final String incrementTooltip;

  @override
  State<QuantityStepper> createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue.clamp(widget.min, widget.max);
  }

  @override
  void didUpdateWidget(covariant QuantityStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_value < widget.min || _value > widget.max) {
      _value = _value.clamp(widget.min, widget.max);
    }
  }

  void _applyDelta(int delta) {
    final nextValue = nextStepperValue(
      current: _value,
      delta: delta,
      min: widget.min,
      max: widget.max,
    );

    if (nextValue == _value) {
      return;
    }

    setState(() {
      _value = nextValue;
    });

    widget.onChanged?.call(nextValue);

    if (nextValue == widget.max) {
      widget.onLimitReached?.call(StepperLimit.max);
    } else if (nextValue == widget.min) {
      widget.onLimitReached?.call(StepperLimit.min);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool canDecrement = _value > widget.min;
    final bool canIncrement = _value < widget.max;

    return Semantics(
      label: widget.semanticLabel,
      value: '$_value',
      container: true,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                key: const Key('stepper_decrement_button'),
                icon: const Icon(Icons.remove),
                tooltip: widget.decrementTooltip,
                onPressed: canDecrement ? () => _applyDelta(-widget.step) : null,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 40),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '$_value',
                  key: const Key('stepper_value_text'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                key: const Key('stepper_increment_button'),
                icon: const Icon(Icons.add),
                tooltip: widget.incrementTooltip,
                onPressed: canIncrement ? () => _applyDelta(widget.step) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
