# ui_kit_dam

Biblioteca de componentes UI para Flutter desarrollada para el módulo de **Diseño de Interfaces (DAM)** por **Antonio Cano Ruiz**.

## Características

* **`QuantityStepper`**: Selector interactivo de cantidad con validaciones estrictas, protección contra desbordamiento en release, soporte de accesibilidad y eventos de límite.
* **`StarRating`**: Componente de valoración interactivo con estrellas personalizables.
* **`InfoBadge`**: Insignia presentacional (`StatelessWidget`) para estados e indicadores visuales.

---

## Componente `QuantityStepper`

`QuantityStepper` es un control paso a paso que permite a los usuarios seleccionar un valor entero dentro de un rango predefinido mediante botones de incremento (`+`) y decremento (`−`).

### Propiedades y Configuración

| Propiedad | Tipo | Valor por defecto | Descripción |
|---|---|---|---|
| `min` | `int` | `0` | Límite inferior permitido. |
| `max` | `int` | `10` | Límite superior permitido. |
| `step` | `int` | `1` | Salto aplicado al pulsar los botones (+ o −). |
| `initialValue` | `int` | igual a `min` | Valor inicial del selector (debe estar entre `min` y `max`). |
| `onChanged` | `ValueChanged<int>?` | `null` | Se emite con el nuevo valor en cada modificación efectiva. |
| `onLimitReached` | `LimitReached?` | `null` | Se emite cuando el valor alcanza `StepperLimit.min` o `StepperLimit.max`. |
| `semanticLabel` | `String` | `'Cantidad'` | Etiqueta de accesibilidad para lectores de pantalla. |
| `decrementTooltip` | `String` | `'Restar'` | Tooltip descriptivo para el botón de restar. |
| `incrementTooltip` | `String` | `'Sumar'` | Tooltip descriptivo para el botón de sumar. |

### Validaciones y Robustez

1. **Aserciones en desarrollo**: Comprueba que `min < max`, `step > 0` y que `initialValue` se sitúe dentro de `[min, max]`.
2. **Seguridad en release**: El valor nunca puede rebasar los límites incluso si se modifican propiedades externamente, gracias a la función pura `nextStepperValue` y al clamping automático en tiempo de ejecución.
3. **Estado de botones**: El botón de restar (`−`) se deshabilita automáticamente al alcanzar el valor mínimo, y el botón de sumar (`+`) se deshabilita al alcanzar el máximo.
4. **Emisión de eventos**: No se dispara ningún evento si el valor no cambia.

### Ejemplo de uso

```dart
import 'package:flutter/material.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

class TicketCounter extends StatefulWidget {
  const TicketCounter({super.key});

  @override
  State<TicketCounter> createState() => _TicketCounterState();
}

class _TicketCounterState extends State<TicketCounter> {
  int _tickets = 1;

  @override
  Widget build(BuildContext context) {
    return QuantityStepper(
      min: 1,
      max: 8,
      step: 1,
      initialValue: 1,
      semanticLabel: 'Número de entradas',
      decrementTooltip: 'Quitar entrada',
      incrementTooltip: 'Añadir entrada',
      onChanged: (newValue) {
        setState(() {
          _tickets = newValue;
        });
      },
      onLimitReached: (limit) {
        if (limit == StepperLimit.max) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Has llegado al máximo')),
          );
        }
      },
    );
  }
}
```

---

## Componentes adicionales

### `StarRating`
Selector interactivo de estrellas para valorar eventos o productos:
```dart
StarRating(
  initialRating: 4,
  maxRating: 5,
  onRatingChanged: (rating) {
    print('Valoración seleccionada: $rating');
  },
)
```

### `InfoBadge`
Insignia informativa sin estado (`StatelessWidget`):
```dart
InfoBadge(
  label: 'Disponible',
  icon: Icons.check_circle,
  color: Colors.green,
)
```

---

## Instalación

Para utilizar este paquete en una aplicación Flutter, agrégalo a tu `pubspec.yaml`:

```yaml
dependencies:
  ui_kit_dam:
    git:
      url: git@github.com:antcanor/Diseno-de-Interfaces.git
      ref: v1.1.0
      path: actividad 2 tema 3/ui_kit_dam
```

---
*Desarrollado por Antonio Cano Ruiz para la asignatura Diseño de Interfaces - DAM.*
