import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// iOS 26 Liquid Glass design tokens.
///
/// Central definition of blur radii, glass alphas, specular highlights and
/// corner radii used across the whole app. Keep every glassy surface
/// referencing these tokens instead of hard-coding values.
class GlassTokens {
  // ---------------------------------------------------------------------------
  // Blur
  // ---------------------------------------------------------------------------
  /// Heavy blur for large floating layers (drawers, sheets, docked panels).
  static const double blurHeavy = 32;

  /// Standard blur for app bars, cards and floating chips.
  static const double blurMedium = 22;

  /// Light blur for small controls (buttons, toggles, segmented controls).
  static const double blurLight = 14;

  // ---------------------------------------------------------------------------
  // Radii (continuous-feeling large corners, iOS 26 style)
  // ---------------------------------------------------------------------------
  static const double radiusSheet = 34;
  static const double radiusCard = 22;
  static const double radiusTile = 18;
  static const double radiusChip = 13;
  static const double radiusButton = 15;

  // ---------------------------------------------------------------------------
  // Glass tint
  // ---------------------------------------------------------------------------
  /// White overlay alpha for light glass surfaces.
  static const double tintLight = 0.58;

  /// White overlay alpha for dark glass surfaces.
  static const double tintDark = 0.13;

  // ---------------------------------------------------------------------------
  // Specular border highlight
  // ---------------------------------------------------------------------------
  static const double borderLight = 0.9;
  static const double borderDark = 0.28;

  // ---------------------------------------------------------------------------
  // Shadows (soft ambient, iOS-like)
  // ---------------------------------------------------------------------------
  static const List<BoxShadow> shadowLight = [
    BoxShadow(
      color: Color(0x16223B6E),
      blurRadius: 26,
      offset: Offset(0, 10),
      spreadRadius: -8,
    ),
  ];

  static const List<BoxShadow> shadowDark = [
    BoxShadow(
      color: Color(0x66000000),
      blurRadius: 30,
      offset: Offset(0, 12),
      spreadRadius: -10,
    ),
  ];

  static List<BoxShadow> shadowOf(Brightness b) =>
      b == Brightness.dark ? shadowDark : shadowLight;
}

/// The signature liquid-glass surface.
///
/// Layer stack (bottom → top):
///  1. Optional `BackdropFilter` frosted blur — pass `frost: false` for rows
///     in long scrolling lists where hundreds of blurs would be too costly;
///     translucency + specular border still reads as glass.
///  2. Tint wash + diagonal sheen gradient.
///  3. Child content.
///  4. Hairline gradient specular border + top-edge light strip.
/// Shadows are painted by an outer container so the rounded clip never
/// eats them.
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius,
    this.radius = GlassTokens.radiusCard,
    this.blur = GlassTokens.blurMedium,
    this.frost = true,
    this.padding,
    this.margin,
    this.tint,
    this.borderColor,
    this.showHighlight = true,
    this.shadows,
    this.sheen,
    this.alignment,
    this.width,
    this.height,
  });

  final Widget child;

  /// Full override for the corner radius (defaults to [radius]).
  final BorderRadius? borderRadius;
  final double radius;

  /// Blur sigma. Ignored when [frost] is false.
  final double blur;

  /// When false the widget skips `BackdropFilter` entirely and only renders
  /// the tint + specular border. Use for list items / bubbles in long lists.
  final bool frost;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  /// Tint color; alpha channel controls opacity. Defaults to an adaptive
  /// white tint derived from the surrounding brightness.
  final Color? tint;

  /// Color of the hairline specular border. Defaults to adaptive.
  final Color? borderColor;

  /// Whether to paint the top specular glow along the top edge.
  final bool showHighlight;

  final List<BoxShadow>? shadows;

  /// Optional override for the sheen gradient painted over the tint.
  final Gradient? sheen;

  final AlignmentGeometry? alignment;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveRadius =
        borderRadius ?? BorderRadius.circular(radius);
    final effectiveTint = tint ??
        (isDark
            ? Colors.white.withValues(alpha: GlassTokens.tintDark)
            : Colors.white.withValues(alpha: GlassTokens.tintLight));
    final effectiveBorder = borderColor ??
        (isDark
            ? Colors.white.withValues(alpha: GlassTokens.borderDark)
            : Colors.white.withValues(alpha: GlassTokens.borderLight));
    final effectiveSheen = sheen ??
        LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  Colors.white.withValues(alpha: 0.09),
                  Colors.white.withValues(alpha: 0.02),
                  Colors.white.withValues(alpha: 0.05),
                ]
              : [
                  Colors.white.withValues(alpha: 0.70),
                  Colors.white.withValues(alpha: 0.18),
                  Colors.white.withValues(alpha: 0.38),
                ],
          stops: const [0.0, 0.55, 1.0],
        );

    Widget content = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: alignment != null
          ? Align(alignment: alignment!, child: child)
          : child,
    );

    Widget stack = Stack(
      fit: StackFit.passthrough,
      children: [
        // 1. Frost + tint wash.
        Positioned.fill(
          child: _FrostLayer(
            frost: frost,
            blur: blur,
            tint: effectiveTint,
          ),
        ),
        // 2. Diagonal sheen.
        Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(gradient: effectiveSheen))),
        // 3. Content.
        content,
        // 4. Specular border.
        Positioned.fill(
          child: CustomPaint(
            painter: _SpecularBorderPainter(
              radius: effectiveRadius,
              color: effectiveBorder,
            ),
          ),
        ),
        if (showHighlight)
          Positioned(
            left: 14,
            right: 14,
            top: 0,
            height: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    effectiveBorder.withValues(alpha: 0),
                    effectiveBorder,
                    effectiveBorder.withValues(alpha: 0),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
      ],
    );

    Widget clipped = ClipRRect(
      borderRadius: effectiveRadius,
      child: stack,
    );

    Widget decorated = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: effectiveRadius,
        boxShadow: shadows,
      ),
      child: clipped,
    );

    Widget sized = (width != null || height != null)
        ? SizedBox(width: width, height: height, child: decorated)
        : decorated;

    return margin != null
        ? Padding(padding: margin!, child: sized)
        : sized;
  }
}

class _FrostLayer extends StatelessWidget {
  const _FrostLayer({required this.frost, required this.blur, required this.tint});

  final bool frost;
  final double blur;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    if (!frost) {
      return ColoredBox(color: tint);
    }
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: blur,
        sigmaY: blur,
        tileMode: TileMode.mirror,
      ),
      child: ColoredBox(color: tint),
    );
  }
}

/// Draws a hairline rounded-rect stroke whose color fades diagonally,
/// giving glass edges their "lit from the top-left" specular quality.
class _SpecularBorderPainter extends CustomPainter {
  _SpecularBorderPainter({required this.radius, required this.color});

  final BorderRadius radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 1.0;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    final rrect = radius.toRRect(rect);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..isAntiAlias = true
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color,
          color.withValues(alpha: color.a * 0.25),
          color.withValues(alpha: color.a * 0.55),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Offset.zero & size);
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_SpecularBorderPainter old) =>
      old.color != color || old.radius != radius;
}

/// Liquid-glass card used for grouped content (settings sections, tool
/// cards, message attachments…).
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.radius = GlassTokens.radiusCard,
    this.frost = true,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.tint,
    this.shadows,
    this.showHighlight = true,
    this.width,
    this.height,
  });

  final Widget child;
  final double radius;
  final bool frost;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? tint;
  final List<BoxShadow>? shadows;
  final bool showHighlight;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      radius: radius,
      frost: frost,
      padding: padding,
      margin: margin,
      tint: tint,
      width: width,
      height: height,
      shadows: shadows ?? GlassTokens.shadowOf(Theme.of(context).brightness),
      showHighlight: showHighlight,
      child: child,
    );
  }
}

/// Floating glass pill button (iOS 26 capsule style).
class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.filled = false,
    this.icon,
    this.radius = GlassTokens.radiusButton,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    this.backgroundColor,
    this.foregroundColor,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Widget? icon;
  final bool filled;
  final double radius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fg = foregroundColor ??
        (filled ? Colors.white : theme.colorScheme.onSurface);
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          IconTheme(
            data: IconThemeData(color: fg, size: 18),
            child: icon!,
          ),
          const SizedBox(width: 8),
        ],
        DefaultTextStyle(
          style: theme.textTheme.labelLarge!.copyWith(
            color: fg,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
          child: child,
        ),
      ],
    );

    if (filled) {
      return _PressableGlass(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                (backgroundColor ?? theme.colorScheme.primary)
                    .withValues(alpha: 0.9),
                backgroundColor ?? theme.colorScheme.primary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: (backgroundColor ?? theme.colorScheme.primary)
                    .withValues(alpha: isDark ? 0.45 : 0.35),
                blurRadius: 18,
                offset: const Offset(0, 6),
                spreadRadius: -4,
              ),
            ],
          ),
          padding: padding,
          child: content,
        ),
      );
    }

    return _PressableGlass(
      onPressed: onPressed,
      child: GlassContainer(
        radius: radius,
        blur: GlassTokens.blurLight,
        padding: padding,
        tint: backgroundColor ??
            (isDark
                ? Colors.white.withValues(alpha: 0.10)
                : Colors.white.withValues(alpha: 0.55)),
        child: content,
      ),
    );
  }
}

/// Wraps a child with press-scale feedback (iOS-like springy touch).
class _PressableGlass extends StatefulWidget {
  const _PressableGlass({required this.child, this.onPressed});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  State<_PressableGlass> createState() => _PressableGlassState();
}

class _PressableGlassState extends State<_PressableGlass> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown:
          widget.onPressed == null ? null : (_) => setState(() => _pressed = true),
      onTapUp:
          widget.onPressed == null ? null : (_) => setState(() => _pressed = false),
      onTapCancel:
          widget.onPressed == null ? null : () => setState(() => _pressed = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

/// A liquid-glass circular icon button.
class GlassIconButton extends StatelessWidget {
  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 38,
    this.iconSize,
    this.color,
    this.filled = false,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final double? iconSize;
  final Color? color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fg = color ??
        (filled
            ? Colors.white
            : isDark
                ? const Color(0xFFEBEBF5)
                : const Color(0xFF1C1C1E));

    Widget inner = SizedBox(
      width: size,
      height: size,
      child: filled
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.9),
                    theme.colorScheme.primary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary
                        .withValues(alpha: isDark ? 0.4 : 0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                    spreadRadius: -3,
                  ),
                ],
              ),
              child: Center(
                child: IconTheme(
                  data: IconThemeData(color: fg, size: iconSize ?? 19),
                  child: icon,
                ),
              ),
            )
          : GlassContainer(
              radius: size / 2,
              blur: GlassTokens.blurLight,
              tint: isDark
                  ? Colors.white.withValues(alpha: 0.10)
                  : Colors.white.withValues(alpha: 0.55),
              padding: EdgeInsets.zero,
              child: Center(
                child: IconTheme(
                  data: IconThemeData(color: fg, size: iconSize ?? 19),
                  child: icon,
                ),
              ),
            ),
    );

    inner = _PressableGlass(onPressed: onPressed, child: inner);

    if (tooltip != null) {
      inner = Tooltip(message: tooltip!, child: inner);
    }
    return inner;
  }
}

/// Ambient mesh-gradient backdrop that gives every frosted surface something
/// beautiful to blur. Sits directly above the scaffold background.
class GlassBackground extends StatelessWidget {
  const GlassBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF0B0C12), Color(0xFF101322), Color(0xFF0A0B10)]
              : const [Color(0xFFEFF3FA), Color(0xFFE9F0F9), Color(0xFFF4F1FA)],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Color blooms — light mode: airy pastels; dark mode: deep neons.
          Positioned(
            top: -140,
            left: -80,
            child: _Bloom(
              size: 420,
              color: isDark ? const Color(0x66254BFF) : const Color(0x5CB8D4FF),
            ),
          ),
          Positioned(
            top: 80,
            right: -160,
            child: _Bloom(
              size: 460,
              color: isDark ? const Color(0x4DA24BFF) : const Color(0x59D7B9FF),
            ),
          ),
          Positioned(
            bottom: -180,
            left: -60,
            child: _Bloom(
              size: 500,
              color: isDark ? const Color(0x4000C6FF) : const Color(0x50FFE1C9),
            ),
          ),
          Positioned(
            bottom: 60,
            right: -120,
            child: _Bloom(
              size: 380,
              color: isDark ? const Color(0x40FF6EC7) : const Color(0x47FFD3E0),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

class _Bloom extends StatelessWidget {
  const _Bloom({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

/// Shows a liquid-glass modal bottom sheet with a frosted backdrop.
Future<T?> showGlassBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = false,
  bool useSafeArea = true,
  Color? barrierColor,
  String? barrierLabel,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    barrierLabel: barrierLabel,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor ??
        (isDark ? Colors.black54 : Colors.black.withValues(alpha: 0.32)),
    builder: (ctx) => _GlassSheet(child: Builder(builder: builder)),
  );
}

class _GlassSheet extends StatelessWidget {
  const _GlassSheet({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: GlassTokens.blurHeavy,
        sigmaY: GlassTokens.blurHeavy,
        tileMode: TileMode.mirror,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xE6141620) : const Color(0xE6F7F9FD),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(GlassTokens.radiusSheet),
          ),
          border: Border(
            top: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.18)
                  : Colors.white.withValues(alpha: 0.9),
              width: 1,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

/// iOS 26-style segmented control rendered on a glass track.
class GlassSegmented<T> extends StatelessWidget {
  const GlassSegmented({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.small = false,
  });

  final List<({T value, Widget label})> segments;
  final T selected;
  final ValueChanged<T> onChanged;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return GlassContainer(
      radius: GlassTokens.radiusChip,
      blur: GlassTokens.blurLight,
      padding: const EdgeInsets.all(3),
      tint: isDark
          ? Colors.white.withValues(alpha: 0.06)
          : Colors.white.withValues(alpha: 0.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final seg in segments)
            GestureDetector(
              onTap: () => onChanged(seg.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.symmetric(
                  horizontal: small ? 12 : 16,
                  vertical: small ? 5 : 7,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(GlassTokens.radiusChip - 3),
                  color: seg.value == selected
                      ? (isDark
                          ? Colors.white.withValues(alpha: 0.16)
                          : Colors.white)
                      : Colors.transparent,
                  boxShadow: seg.value == selected
                      ? [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.3)
                                : const Color(0x1E1C344C),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                            spreadRadius: -2,
                          ),
                        ]
                      : null,
                ),
                child: DefaultTextStyle(
                  style: (small
                          ? theme.textTheme.labelSmall
                          : theme.textTheme.labelMedium)!
                      .copyWith(
                        fontWeight: seg.value == selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: seg.value == selected
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                  child: seg.label,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Renders a drag handle used inside glass bottom sheets.
class GlassDragHandle extends StatelessWidget {
  const GlassDragHandle({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 40,
      height: 5,
      margin: const EdgeInsets.only(top: 10, bottom: 6),
      decoration: BoxDecoration(
        color: color ??
            (isDark
                ? Colors.white.withValues(alpha: 0.28)
                : Colors.black.withValues(alpha: 0.16)),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
