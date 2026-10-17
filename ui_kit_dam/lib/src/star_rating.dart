import 'package:flutter/material.dart';

/// Un componente interactivo para seleccionar valoraciones mediante estrellas.
///
/// Permite al usuario calificar un elemento seleccionando de 1 a [maxRating] estrellas.
///
/// Ejemplo de uso:
/// ```dart
/// StarRating(
///   initialRating: 4,
///   onRatingChanged: (rating) => print('Valoración: $rating'),
/// )
/// ```
class StarRating extends StatefulWidget {
  /// Crea un selector de valoración con estrellas.
  const StarRating({
    super.key,
    this.initialRating = 0,
    this.maxRating = 5,
    this.onRatingChanged,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
    this.semanticLabel = 'Valoración',
  })  : assert(maxRating > 0, 'maxRating debe ser mayor que 0'),
        assert(
          initialRating >= 0 && initialRating <= maxRating,
          'initialRating debe estar entre 0 y maxRating',
        );

  /// Valor inicial de estrellas seleccionadas (de 0 a [maxRating]).
  final int initialRating;

  /// Cantidad total de estrellas disponibles. Por defecto es 5.
  final int maxRating;

  /// Callback emitido cuando el usuario selecciona una nueva calificación.
  final ValueChanged<int>? onRatingChanged;

  /// Color para las estrellas activas (seleccionadas). Por defecto es ámbar.
  final Color activeColor;

  /// Color para las estrellas inactivas. Por defecto es gris.
  final Color inactiveColor;

  /// Etiqueta de accesibilidad para lectores de pantalla. Por defecto 'Valoración'.
  final String semanticLabel;

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating.clamp(0, widget.maxRating);
  }

  @override
  void didUpdateWidget(covariant StarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialRating != oldWidget.initialRating) {
      _rating = widget.initialRating.clamp(0, widget.maxRating);
    }
  }

  void _selectRating(int rating) {
    if (_rating == rating) return;
    setState(() {
      _rating = rating;
    });
    widget.onRatingChanged?.call(rating);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      value: '$_rating de ${widget.maxRating}',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.maxRating, (index) {
          final starNumber = index + 1;
          final isSelected = starNumber <= _rating;

          return IconButton(
            key: Key('star_rating_$starNumber'),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
            icon: Icon(
              isSelected ? Icons.star : Icons.star_border,
              color: isSelected ? widget.activeColor : widget.inactiveColor,
            ),
            tooltip: '$starNumber de ${widget.maxRating}',
            onPressed: () => _selectRating(starNumber),
          );
        }),
      ),
    );
  }
}
