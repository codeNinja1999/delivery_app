import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppOverlays {
  const AppOverlays._();

  /// Returns the "effective" brightness based on ThemeMode + system setting.
  static Brightness effectiveBrightness(
    BuildContext context,
    ThemeMode mode,
  ) {
    switch (mode) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.system:
        // Use platform/system brightness
        return MediaQuery.platformBrightnessOf(context);
    }
  }

  /// Theme-aware overlay style.
  /// - barColor: optional override for both status + nav bars
  /// - If omitted, it uses Theme's scaffoldBackgroundColor.
  static SystemUiOverlayStyle of(
    BuildContext context, {
    required ThemeMode mode,
    Color? barColor,
    bool disableNavContrastEnforcement = true,
  }) {
    final brightness = effectiveBrightness(context, mode);

    final bg = barColor ?? Theme.of(context).scaffoldBackgroundColor;

    // Decide icon brightness based on background color (more robust than only theme)
    final isDarkBg = ThemeData.estimateBrightnessForColor(bg) == Brightness.dark;

    final androidIcons = isDarkBg ? Brightness.light : Brightness.dark;

    return SystemUiOverlayStyle(
      // These colors may be ignored on Android 15/16 edge-to-edge, but harmless.
      statusBarColor: bg,
      systemNavigationBarColor: bg,

      // Android icon colors
      statusBarIconBrightness: androidIcons,
      systemNavigationBarIconBrightness: androidIcons,

      // iOS uses statusBarBrightness; inverse mapping for icon visibility
      statusBarBrightness: brightness == Brightness.dark ? Brightness.dark : Brightness.light,

      // Helps reduce Android’s nav bar scrim behavior (3-button)
      systemNavigationBarContrastEnforced: disableNavContrastEnforcement ? false : null,
    );
  }
}
