import 'package:flutter/material.dart';
import '../../../../theme/glass.dart';

/// Liquid-glass row card shared by all compact tool cards (bash / edit /
/// batch / …) in the chat timeline.
///
/// Uses [GlassContainer] with `frost: false` — a translucent tint + specular
/// hairline border + diagonal sheen, no `BackdropFilter`, so long timelines
/// stay cheap to rebuild during streaming.
class ToolGlassCard extends StatelessWidget {
  const ToolGlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.margin = const EdgeInsets.only(top: 2, bottom: 2),
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    this.radius = 14,
    this.leading,
    this.trailing,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double radius;

  /// Optional leading icon capsule rendered inside a tinted glass pill.
  final Widget? leading;

  /// Optional trailing widget (spinner / chevron).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final body = Padding(
      padding: padding,
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 8),
          ],
          Expanded(child: child),
          if (trailing != null) ...[
            const SizedBox(width: 6),
            trailing!,
          ],
        ],
      ),
    );

    return Padding(
      padding: margin,
      child: GlassContainer(
        radius: radius,
        frost: false,
        tint: isDark
            ? Colors.white.withValues(alpha: 0.10)
            : Colors.white.withValues(alpha: 0.62),
        borderColor: isDark
            ? Colors.white.withValues(alpha: 0.22)
            : Colors.white.withValues(alpha: 0.9),
        child: onTap == null
            ? body
            : InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(radius),
                child: body,
              ),
      ),
    );
  }
}

/// Small tinted icon capsule used as the leading element of [ToolGlassCard].
class ToolIconCapsule extends StatelessWidget {
  const ToolIconCapsule({super.key, required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.22 : 0.13),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: isDark ? 0.35 : 0.25),
          width: 0.5,
        ),
      ),
      child: Icon(icon, size: 13, color: color),
    );
  }
}
