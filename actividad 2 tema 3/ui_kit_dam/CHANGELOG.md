# Changelog

All notable changes to this project will be documented in this file.

## 1.1.0

### Añadido
* **Componente `QuantityStepper`**:
  * Nuevo widget interactivo (`StatefulWidget`) para seleccionar cantidades enteras mediante botones `+` y `−`.
  * Función pura `nextStepperValue` desacoplada del widget para facilitar la testeabilidad y asegurar el rango `[min, max]` en cualquier entorno (incluido release).
  * Validaciones mediante aserciones para `min < max`, `step > 0` e `initialValue` en el rango permitido.
  * Desactivación reactiva de los botones al alcanzar los límites extremos.
  * Eventos `onChanged` (emite el nuevo valor entero) y `onLimitReached` (emite el enum `StepperLimit.min` o `StepperLimit.max`).
  * Propiedades de accesibilidad y personalización textual: `semanticLabel`, `decrementTooltip` e `incrementTooltip`.
* **Pruebas y Calidad**:
  * Batería completa de pruebas unitarias para `nextStepperValue`.
  * Pruebas de widget verificando interacción, deshabilitación de botones y emisión de eventos.
  * Prueba golden de renderizado visual (`test/goldens/quantity_stepper_val5.png`).
  * Cobertura de pruebas del 100% sobre `quantity_stepper.dart`.
* **Documentación y Catálogo**:
  * Documentación con `///` para todos los elementos públicos y regla `public_member_api_docs` activa sin advertencias.
  * Generación de documentación HTML con `dart doc`.
  * Catálogo de componentes en Widgetbook con casos "Por defecto" y "Configurable" con knobs.
* **Componentes auxiliares del kit**:
  * `StarRating`: componente interactivo para valoración con estrellas.
  * `InfoBadge`: componente presentacional (`StatelessWidget`) para insignias y estados.

## 1.0.0

* Versión base inicial de la biblioteca `ui_kit_dam`.
