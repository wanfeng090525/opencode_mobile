import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../init.dart';

const _fontFamilyFallback = [
  'SF Pro',
  'Microsoft YaHei',
  'PingFang SC',
  'Noto Sans SC',
  'Segoe UI',
  'Roboto',
];

const TextTheme _lightTextTheme = TextTheme(
  displayLarge: TextStyle(
    color: PremiumColors.lightText,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
  ),
  displayMedium: TextStyle(
    color: PremiumColors.lightText,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
  ),
  displaySmall: TextStyle(
    color: PremiumColors.lightText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  ),
  headlineLarge: TextStyle(
    color: PremiumColors.lightText,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  ),
  headlineMedium: TextStyle(
    color: PremiumColors.lightText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  ),
  headlineSmall: TextStyle(
    color: PremiumColors.lightText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
  ),
  titleLarge: TextStyle(
    color: PremiumColors.lightText,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  ),
  titleMedium: TextStyle(
    color: PremiumColors.lightText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
  ),
  titleSmall: TextStyle(
    color: PremiumColors.lightText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  ),
  bodyLarge: TextStyle(
    color: PremiumColors.lightText,
    letterSpacing: -0.1,
  ),
  bodyMedium: TextStyle(
    color: PremiumColors.lightText,
    letterSpacing: -0.1,
  ),
  bodySmall: TextStyle(color: PremiumColors.lightSecondaryText, fontSize: 12),
  labelLarge: TextStyle(
    color: PremiumColors.lightText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  ),
  labelMedium: TextStyle(color: PremiumColors.lightText, fontSize: 12),
  labelSmall: TextStyle(
    color: PremiumColors.lightSecondaryText,
    fontSize: 11,
    letterSpacing: -0.1,
  ),
);

const TextTheme _darkTextTheme = TextTheme(
  displayLarge: TextStyle(
    color: PremiumColors.darkText,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
  ),
  displayMedium: TextStyle(
    color: PremiumColors.darkText,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
  ),
  displaySmall: TextStyle(
    color: PremiumColors.darkText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  ),
  headlineLarge: TextStyle(
    color: PremiumColors.darkText,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  ),
  headlineMedium: TextStyle(
    color: PremiumColors.darkText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  ),
  headlineSmall: TextStyle(
    color: PremiumColors.darkText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
  ),
  titleLarge: TextStyle(
    color: PremiumColors.darkText,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  ),
  titleMedium: TextStyle(
    color: PremiumColors.darkText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
  ),
  titleSmall: TextStyle(
    color: PremiumColors.darkText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  ),
  bodyLarge: TextStyle(
    color: PremiumColors.darkText,
    letterSpacing: -0.1,
  ),
  bodyMedium: TextStyle(
    color: PremiumColors.darkText,
    letterSpacing: -0.1,
  ),
  bodySmall: TextStyle(color: PremiumColors.darkSecondaryText, fontSize: 12),
  labelLarge: TextStyle(
    color: PremiumColors.darkText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  ),
  labelMedium: TextStyle(color: PremiumColors.darkText, fontSize: 12),
  labelSmall: TextStyle(
    color: PremiumColors.darkSecondaryText,
    fontSize: 11,
    letterSpacing: -0.1,
  ),
);

/// iOS 26 Liquid Glass palette.
///
/// System-inspired hues (SF blues/greens/reds) tuned to float on translucent
/// frosted surfaces. Every static keeps its historical name so call-sites
/// across the app stay source-compatible.
class PremiumColors {
  // Primary — iOS system blue family.
  static const Color primary = Color(0xFF0A84FF);
  static const Color primaryAccent = Color(0xFF64D2FF);
  static const Color primaryDark = Color(0xFF64D2FF);
  static const Color primaryContainerLight = Color(0xFFD6EBFF);
  static const Color primaryContainerDark = Color(0xFF0A3D80);

  // Backgrounds & surfaces — airy light mesh / deep midnight glass.
  static const Color lightBackground = Color(0xFFEFF3FA);
  static const Color lightSurface = Color(0xFFFCFDFF);
  static const Color lightSidebar = Color(0xFFF3F6FB);
  static const Color lightRail = Color(0xFFF3F6FB);
  static const Color lightPanel = Color(0xFFFCFDFF);
  static const Color lightInputBg = Color(0xFFEFF2F8);
  static const Color lightChipBg = Color(0xFFE9EEF6);
  static const Color lightSurfaceHighest = Color(0xFFE9EEF6);
  static const Color darkBackground = Color(0xFF0A0B10);
  static const Color darkSurface = Color(0xFF14161F);
  static const Color darkSidebar = Color(0xFF101219);
  static const Color darkRail = Color(0xFF101219);
  static const Color darkPanel = Color(0xFF14161F);
  static const Color darkInputBg = Color(0xFF1B1E2B);
  static const Color darkChipBg = Color(0xFF232739);
  static const Color darkSurfaceHighest = Color(0xFF232739);

  // Typography — iOS label hierarchy.
  static const Color lightText = Color(0xFF111318);
  static const Color lightSecondaryText = Color(0xFF5C6370);
  static const Color darkText = Color(0xFFF5F6FA);
  static const Color darkSecondaryText = Color(0xFF9BA3B4);

  // Dividers & semantic accents.
  static const Color lightDivider = Color(0xFFDFE4EE);
  static const Color darkDivider = Color(0xFF2A2E3F);
  static const Color success = Color(0xFF30D158);
  static const Color warning = Color(0xFFFFD60A);
  static const Color error = Color(0xFFFF453A);
  static const Color errorContainerLight = Color(0xFFFFE9E7);
  static const Color errorContainerDark = Color(0xFF3A1512);
  static const Color onErrorContainerLight = Color(0xFF6B1310);
  static const Color onErrorContainerDark = Color(0xFFFFEDEC);
  static const Color errorOutlineLight = Color(0xFFFFB4AE);
  static const Color errorOutlineDark = Color(0xFF6B241F);

  // Diff / terminal accents.
  static const Color diffAddBgLight = Color(0x2E34C759);
  static const Color diffAddBgDark = Color(0x3324A146);
  static const Color diffRemoveBgLight = Color(0x2EFF453A);
  static const Color diffRemoveBgDark = Color(0x38C0352F);
  static const Color diffFgLight = Color(0xFF2A2D34);
  static const Color diffFgDark = Color(0xFFDDE1EA);
  static const Color bashAccentLight = Color(0xFF1F8A4C);
  static const Color bashAccentDark = Color(0xFF66E39B);

  // Avatar gradient anchors — vivid iOS tones.
  static const List<Color> avatarColors = [
    Color(0xFF0A84FF),
    Color(0xFFFF375F),
    Color(0xFFBF5AF2),
    Color(0xFF30B0C7),
    Color(0xFF5E5CE6),
    Color(0xFF64D2FF),
    Color(0xFFFF9F0A),
  ];

  /// Helper: pick surface/bg for current brightness
  static Color background(Brightness b) =>
      b == Brightness.dark ? darkBackground : lightBackground;
  static Color surface(Brightness b) =>
      b == Brightness.dark ? darkSurface : lightSurface;
  static Color sidebar(Brightness b) =>
      b == Brightness.dark ? darkSidebar : lightSidebar;
  static Color rail(Brightness b) => b == Brightness.dark ? darkRail : lightRail;
  static Color panel(Brightness b) =>
      b == Brightness.dark ? darkPanel : lightPanel;
  static Color inputBg(Brightness b) =>
      b == Brightness.dark ? darkInputBg : lightInputBg;
  static Color chipBg(Brightness b) =>
      b == Brightness.dark ? darkChipBg : lightChipBg;
  static Color divider(Brightness b) =>
      b == Brightness.dark ? darkDivider : lightDivider;
  static Color text(Brightness b) => b == Brightness.dark ? darkText : lightText;
  static Color secondaryText(Brightness b) =>
      b == Brightness.dark ? darkSecondaryText : lightSecondaryText;
  static Color avatarColor(String initials) {
    if (initials.isEmpty) return avatarColors[0];
    return avatarColors[initials.codeUnitAt(0) % avatarColors.length];
  }
}

/// App-specific colors that don't fit cleanly into [ColorScheme].
@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color inputBg;
  final Color chipBg;
  final Color toolCardBg;
  final Color success;
  final Color warning;
  final Color diffAddBg;
  final Color diffRemoveBg;
  final Color diffFg;
  final Color bashAccent;
  final Color errorSoftBg;
  final Color errorOutline;

  const AppThemeColors({
    required this.inputBg,
    required this.chipBg,
    required this.toolCardBg,
    required this.success,
    required this.warning,
    required this.diffAddBg,
    required this.diffRemoveBg,
    required this.diffFg,
    required this.bashAccent,
    required this.errorSoftBg,
    required this.errorOutline,
  });

  static const light = AppThemeColors(
    inputBg: Color(0xCCFFFFFF),
    chipBg: PremiumColors.lightChipBg,
    toolCardBg: Color(0xB8FFFFFF),
    success: PremiumColors.success,
    warning: Color(0xFFB25E00),
    diffAddBg: PremiumColors.diffAddBgLight,
    diffRemoveBg: PremiumColors.diffRemoveBgLight,
    diffFg: PremiumColors.diffFgLight,
    bashAccent: PremiumColors.bashAccentLight,
    errorSoftBg: Color(0x14FF453A),
    errorOutline: PremiumColors.errorOutlineLight,
  );

  static const dark = AppThemeColors(
    inputBg: Color(0x66FFFFFF),
    chipBg: Color(0x33FFFFFF),
    toolCardBg: Color(0x30FFFFFF),
    success: PremiumColors.success,
    warning: Color(0xFFFFD60A),
    diffAddBg: PremiumColors.diffAddBgDark,
    diffRemoveBg: PremiumColors.diffRemoveBgDark,
    diffFg: PremiumColors.diffFgDark,
    bashAccent: PremiumColors.bashAccentDark,
    errorSoftBg: Color(0x1FFF453A),
    errorOutline: PremiumColors.errorOutlineDark,
  );

  @override
  AppThemeColors copyWith({
    Color? inputBg,
    Color? chipBg,
    Color? toolCardBg,
    Color? success,
    Color? warning,
    Color? diffAddBg,
    Color? diffRemoveBg,
    Color? diffFg,
    Color? bashAccent,
    Color? errorSoftBg,
    Color? errorOutline,
  }) {
    return AppThemeColors(
      inputBg: inputBg ?? this.inputBg,
      chipBg: chipBg ?? this.chipBg,
      toolCardBg: toolCardBg ?? this.toolCardBg,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      diffAddBg: diffAddBg ?? this.diffAddBg,
      diffRemoveBg: diffRemoveBg ?? this.diffRemoveBg,
      diffFg: diffFg ?? this.diffFg,
      bashAccent: bashAccent ?? this.bashAccent,
      errorSoftBg: errorSoftBg ?? this.errorSoftBg,
      errorOutline: errorOutline ?? this.errorOutline,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      inputBg: Color.lerp(inputBg, other.inputBg, t)!,
      chipBg: Color.lerp(chipBg, other.chipBg, t)!,
      toolCardBg: Color.lerp(toolCardBg, other.toolCardBg, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      diffAddBg: Color.lerp(diffAddBg, other.diffAddBg, t)!,
      diffRemoveBg: Color.lerp(diffRemoveBg, other.diffRemoveBg, t)!,
      diffFg: Color.lerp(diffFg, other.diffFg, t)!,
      bashAccent: Color.lerp(bashAccent, other.bashAccent, t)!,
      errorSoftBg: Color.lerp(errorSoftBg, other.errorSoftBg, t)!,
      errorOutline: Color.lerp(errorOutline, other.errorOutline, t)!,
    );
  }
}

extension AppThemeX on BuildContext {
  AppThemeColors get appColors =>
      Theme.of(this).extension<AppThemeColors>() ?? AppThemeColors.dark;
}

/// Shared component theming for the liquid-glass look.
InputDecorationTheme _inputTheme(ColorScheme scheme, Color fill, Color border) {
  return InputDecorationTheme(
    filled: true,
    fillColor: fill,
    hintStyle: TextStyle(color: scheme.onSurfaceVariant),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: border, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: border, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: scheme.primary.withValues(alpha: 0.7), width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: scheme.error.withValues(alpha: 0.6), width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: scheme.error, width: 1.5),
    ),
  );
}

ThemeData light = ThemeData.light().copyWith(
  primaryColor: PremiumColors.primary,
  // Transparent so the ambient GlassBackground mesh (injected by the app
  // builder) shows through every page.
  scaffoldBackgroundColor: Colors.transparent,
  textTheme: _lightTextTheme.apply(fontFamilyFallback: _fontFamilyFallback),
  colorScheme: const ColorScheme.light(
    primary: PremiumColors.primary,
    onPrimary: Colors.white,
    primaryContainer: PremiumColors.primaryContainerLight,
    onPrimaryContainer: Color(0xFF003B7A),
    secondary: PremiumColors.primaryAccent,
    onSecondary: Color(0xFF00323C),
    secondaryContainer: Color(0xFFD8F4FF),
    onSecondaryContainer: Color(0xFF00323C),
    surface: PremiumColors.lightSurface,
    onSurface: PremiumColors.lightText,
    onSurfaceVariant: PremiumColors.lightSecondaryText,
    surfaceContainerHighest: PremiumColors.lightSurfaceHighest,
    error: PremiumColors.error,
    onError: Colors.white,
    errorContainer: PremiumColors.errorContainerLight,
    onErrorContainer: PremiumColors.onErrorContainerLight,
    outline: PremiumColors.lightDivider,
    outlineVariant: PremiumColors.lightDivider,
  ),
  iconTheme: IconThemeData(
    size: Global.iconSize,
    color: PremiumColors.lightText,
  ),
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: PremiumColors.lightText,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: PremiumColors.lightText,
      fontSize: 17,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  cardTheme: CardThemeData(
    color: PremiumColors.lightSurface,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
      side: BorderSide(color: Colors.white.withValues(alpha: 0.9), width: 1),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: PremiumColors.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: PremiumColors.lightChipBg,
      disabledForegroundColor: PremiumColors.lightSecondaryText,
      elevation: 0,
      shadowColor: PremiumColors.primary.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: PremiumColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: PremiumColors.primary,
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: PremiumColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      side: BorderSide(color: PremiumColors.primary.withValues(alpha: 0.5)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
  inputDecorationTheme: _inputTheme(
    const ColorScheme.light(),
    Colors.white.withValues(alpha: 0.75),
    Colors.white.withValues(alpha: 0.95),
  ),
  dividerTheme: const DividerThemeData(
    color: PremiumColors.lightDivider,
    thickness: 0.5,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: PremiumColors.lightChipBg,
    selectedColor: PremiumColors.primaryContainerLight,
    side: BorderSide.none,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
    labelStyle: const TextStyle(
      color: PremiumColors.lightText,
      fontWeight: FontWeight.w600,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: const Color(0xFFF2F5FB),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    modalBackgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
    ),
    showDragHandle: false,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrimColor: Color(0x33000000),
  ),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xE6121622),
    contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  tabBarTheme: TabBarThemeData(
    labelColor: PremiumColors.primary,
    unselectedLabelColor: PremiumColors.lightSecondaryText,
    dividerColor: Colors.transparent,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: PremiumColors.primary,
    linearTrackColor: Color(0x148A95A8),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.white;
      return Colors.white;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return PremiumColors.success;
      }
      return const Color(0xFFD5DAE4);
    }),
    trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
  ),
  extensions: const <ThemeExtension<dynamic>>[AppThemeColors.light],
);

ThemeData dark = ThemeData.dark().copyWith(
  primaryColor: PremiumColors.primary,
  // Transparent so the ambient GlassBackground mesh (injected by the app
  // builder) shows through every page.
  scaffoldBackgroundColor: Colors.transparent,
  textTheme: _darkTextTheme.apply(fontFamilyFallback: _fontFamilyFallback),
  colorScheme: const ColorScheme.dark(
    primary: PremiumColors.primary,
    onPrimary: Colors.white,
    primaryContainer: PremiumColors.primaryContainerDark,
    onPrimaryContainer: Color(0xFFCCE5FF),
    secondary: PremiumColors.primaryAccent,
    onSecondary: Color(0xFF00323C),
    secondaryContainer: Color(0xFF0E3A47),
    onSecondaryContainer: Color(0xFFCCEEFF),
    surface: PremiumColors.darkSurface,
    onSurface: PremiumColors.darkText,
    onSurfaceVariant: PremiumColors.darkSecondaryText,
    surfaceContainerHighest: PremiumColors.darkSurfaceHighest,
    error: PremiumColors.error,
    onError: Colors.white,
    errorContainer: PremiumColors.errorContainerDark,
    onErrorContainer: PremiumColors.onErrorContainerDark,
    outline: PremiumColors.darkDivider,
    outlineVariant: PremiumColors.darkDivider,
  ),
  iconTheme: IconThemeData(
    size: Global.iconSize,
    color: PremiumColors.darkText,
  ),
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: PremiumColors.darkText,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: PremiumColors.darkText,
      fontSize: 17,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  cardTheme: CardThemeData(
    color: PremiumColors.darkSurface,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
      side: BorderSide(
        color: Colors.white.withValues(alpha: 0.12),
        width: 1,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: PremiumColors.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: PremiumColors.darkChipBg,
      disabledForegroundColor: PremiumColors.darkSecondaryText,
      elevation: 0,
      shadowColor: PremiumColors.primary.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: PremiumColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF64D2FF),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF64D2FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      side: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
  inputDecorationTheme: _inputTheme(
    const ColorScheme.dark(),
    Colors.white.withValues(alpha: 0.07),
    Colors.white.withValues(alpha: 0.14),
  ),
  dividerTheme: const DividerThemeData(
    color: PremiumColors.darkDivider,
    thickness: 0.5,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: PremiumColors.darkChipBg,
    selectedColor: PremiumColors.primaryContainerDark,
    side: BorderSide.none,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
    labelStyle: const TextStyle(
      color: PremiumColors.darkText,
      fontWeight: FontWeight.w600,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: const Color(0xE6151826),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    modalBackgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
    ),
    showDragHandle: false,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrimColor: Color(0x59000000),
  ),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xE6E8ECF7),
    contentTextStyle: const TextStyle(color: Color(0xFF111318), fontSize: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  tabBarTheme: TabBarThemeData(
    labelColor: const Color(0xFF64D2FF),
    unselectedLabelColor: PremiumColors.darkSecondaryText,
    dividerColor: Colors.transparent,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: PremiumColors.primary,
    linearTrackColor: Color(0x14FFFFFF),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: const WidgetStatePropertyAll(Colors.white),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return PremiumColors.success;
      }
      return const Color(0xFF39415A);
    }),
    trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
  ),
  extensions: const <ThemeExtension<dynamic>>[AppThemeColors.dark],
);
