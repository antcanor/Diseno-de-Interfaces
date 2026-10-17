import 'package:flutter/material.dart';

/// Un componente presentacional ([StatelessWidget]) para mostrar estados,
/// etiquetas o contadores de información en forma de insignia.
///
/// Dado que su apariencia y contenido dependen exclusivamente de los datos
/// proporcionados por el componente padre ([label], [color], [icon]), no
/// necesita mantener un estado interno mutable.
///
/// Ejemplo de uso:
/// ```dart
/// InfoBadge(
///   label: 'Disponible',
///   color: Colors.green,
///   icon: Icons.check_circle,
/// )
/// ```
class InfoBadge extends StatelessWidget {
  /// Crea una insignia de información.
  const InfoBadge({
    super.key,
    required this.label,
    this.color,
    this.icon,
  });

  /// Texto descriptivo que se muestra en la insignia.
  final String label;

  /// Color base utilizado para el fondo y el texto de la insignia.
  final Color? color;

  /// Icono opcional que acompaña a la etiqueta de texto.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: effectiveColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: effectiveColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: effectiveColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
