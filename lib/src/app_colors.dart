// ignore_for_file: constant_identifier_names

import "package:base/src/base_preferences.dart";
import "package:base/src/extensions.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class AppColors {
  static const String THEME_MODE = "THEME_MODE";

  static ColorScheme lightColorScheme = const ColorScheme.light();
  static ColorScheme darkColorScheme = const ColorScheme.dark();

  static Brightness brightness() {
    ThemeMode mode = themeMode();

    if (mode == ThemeMode.light) {
      return Brightness.light;
    } else if (mode == ThemeMode.dark) {
      return Brightness.dark;
    } else {
      if (Get.context != null) {
        return MediaQuery.of(Get.context!).platformBrightness;
      }

      return Brightness.light;
    }
  }

  static Brightness brightnessInverse() {
    return darkMode() ? Brightness.light : Brightness.dark;
  }

  static bool darkMode() {
    return brightness() == Brightness.dark;
  }

  static ThemeMode themeMode() {
    int value = BasePreferences.getInstance().getInt(THEME_MODE) ?? 0;

    if (value == 1) return ThemeMode.light;
    if (value == 2) return ThemeMode.dark;
    return ThemeMode.system;
  }

  static Color primary() =>
      darkMode() ? darkColorScheme.primary : lightColorScheme.primary;

  static Color surfaceTint() =>
      darkMode() ? darkColorScheme.surfaceTint : lightColorScheme.surfaceTint;

  static Color onPrimary() =>
      darkMode() ? darkColorScheme.onPrimary : lightColorScheme.onPrimary;

  static Color primaryContainer() => darkMode()
      ? darkColorScheme.primaryContainer
      : lightColorScheme.primaryContainer;

  static Color onPrimaryContainer() => darkMode()
      ? darkColorScheme.onPrimaryContainer
      : lightColorScheme.onPrimaryContainer;

  static Color secondary() =>
      darkMode() ? darkColorScheme.secondary : lightColorScheme.secondary;

  static Color onSecondary() =>
      darkMode() ? darkColorScheme.onSecondary : lightColorScheme.onSecondary;

  static Color secondaryContainer() => darkMode()
      ? darkColorScheme.secondaryContainer
      : lightColorScheme.secondaryContainer;

  static Color onSecondaryContainer() => darkMode()
      ? darkColorScheme.onSecondaryContainer
      : lightColorScheme.onSecondaryContainer;

  static Color tertiary() =>
      darkMode() ? darkColorScheme.tertiary : lightColorScheme.tertiary;

  static Color onTertiary() =>
      darkMode() ? darkColorScheme.onTertiary : lightColorScheme.onTertiary;

  static Color tertiaryContainer() => darkMode()
      ? darkColorScheme.tertiaryContainer
      : lightColorScheme.tertiaryContainer;

  static Color onTertiaryContainer() => darkMode()
      ? darkColorScheme.onTertiaryContainer
      : lightColorScheme.onTertiaryContainer;

  static Color error() =>
      darkMode() ? darkColorScheme.error : lightColorScheme.error;

  static Color onError() =>
      darkMode() ? darkColorScheme.onError : lightColorScheme.onError;

  static Color errorContainer() => darkMode()
      ? darkColorScheme.errorContainer
      : lightColorScheme.errorContainer;

  static Color onErrorContainer() => darkMode()
      ? darkColorScheme.onErrorContainer
      : lightColorScheme.onErrorContainer;

  static Color surface() =>
      darkMode() ? darkColorScheme.surface : lightColorScheme.surface;

  static Color onSurface() =>
      darkMode() ? darkColorScheme.onSurface : lightColorScheme.onSurface;

  static Color onSurfaceVariant() => darkMode()
      ? darkColorScheme.onSurfaceVariant
      : lightColorScheme.onSurfaceVariant;

  static Color outline() =>
      darkMode() ? darkColorScheme.outline : lightColorScheme.outline;

  static Color outlineVariant() => darkMode()
      ? darkColorScheme.outlineVariant
      : lightColorScheme.outlineVariant;

  static Color shadow() =>
      darkMode() ? darkColorScheme.shadow : lightColorScheme.shadow;

  static Color scrim() =>
      darkMode() ? darkColorScheme.scrim : lightColorScheme.scrim;

  static Color inverseSurface() => darkMode()
      ? darkColorScheme.inverseSurface
      : lightColorScheme.inverseSurface;

  static Color inversePrimary() => darkMode()
      ? darkColorScheme.inversePrimary
      : lightColorScheme.inversePrimary;

  static Color primaryFixed() =>
      darkMode() ? darkColorScheme.primaryFixed : lightColorScheme.primaryFixed;

  static Color onPrimaryFixed() => darkMode()
      ? darkColorScheme.onPrimaryFixed
      : lightColorScheme.onPrimaryFixed;

  static Color primaryFixedDim() => darkMode()
      ? darkColorScheme.primaryFixedDim
      : lightColorScheme.primaryFixedDim;

  static Color onPrimaryFixedVariant() => darkMode()
      ? darkColorScheme.onPrimaryFixedVariant
      : lightColorScheme.onPrimaryFixedVariant;

  static Color secondaryFixed() => darkMode()
      ? darkColorScheme.secondaryFixed
      : lightColorScheme.secondaryFixed;

  static Color onSecondaryFixed() => darkMode()
      ? darkColorScheme.onSecondaryFixed
      : lightColorScheme.onSecondaryFixed;

  static Color secondaryFixedDim() => darkMode()
      ? darkColorScheme.secondaryFixedDim
      : lightColorScheme.secondaryFixedDim;

  static Color onSecondaryFixedVariant() => darkMode()
      ? darkColorScheme.onSecondaryFixedVariant
      : lightColorScheme.onSecondaryFixedVariant;

  static Color tertiaryFixed() => darkMode()
      ? darkColorScheme.tertiaryFixed
      : lightColorScheme.tertiaryFixed;

  static Color onTertiaryFixed() => darkMode()
      ? darkColorScheme.onTertiaryFixed
      : lightColorScheme.onTertiaryFixed;

  static Color tertiaryFixedDim() => darkMode()
      ? darkColorScheme.tertiaryFixedDim
      : lightColorScheme.tertiaryFixedDim;

  static Color onTertiaryFixedVariant() => darkMode()
      ? darkColorScheme.onTertiaryFixedVariant
      : lightColorScheme.onTertiaryFixedVariant;

  static Color surfaceDim() =>
      darkMode() ? darkColorScheme.surfaceDim : lightColorScheme.surfaceDim;

  static Color surfaceBright() => darkMode()
      ? darkColorScheme.surfaceBright
      : lightColorScheme.surfaceBright;

  static Color surfaceContainerLowest() => darkMode()
      ? darkColorScheme.surfaceContainerLowest
      : lightColorScheme.surfaceContainerLowest;

  static Color surfaceContainerLow() => darkMode()
      ? darkColorScheme.surfaceContainerLow
      : lightColorScheme.surfaceContainerLow;

  static Color surfaceContainer() => darkMode()
      ? darkColorScheme.surfaceContainer
      : lightColorScheme.surfaceContainer;

  static Color surfaceContainerHigh() => darkMode()
      ? darkColorScheme.surfaceContainerHigh
      : lightColorScheme.surfaceContainerHigh;

  static Color surfaceContainerHighest() => darkMode()
      ? darkColorScheme.surfaceContainerHighest
      : lightColorScheme.surfaceContainerHighest;

  static Color success() =>
      darkMode() ? Colors.green.shade100 : Colors.green.shade700;

  static Color onSuccess() => darkMode() ? Colors.green.shade900 : Colors.white;

  static Color successContainer() =>
      darkMode() ? Colors.green.shade700 : Colors.green.shade100;

  static Color onSuccessContainer() =>
      darkMode() ? Colors.white : Colors.green.shade900;

  static Color warning() =>
      darkMode() ? Colors.orange.shade100 : Colors.orange.shade700;

  static Color onWarning() =>
      darkMode() ? Colors.orange.shade900 : Colors.orange.shade100;

  static Color warningContainer() =>
      darkMode() ? Colors.orange.shade700 : Colors.orange.shade100;

  static Color onWarningContainer() =>
      darkMode() ? Colors.orange.shade100 : Colors.orange.shade900;

  static Color backgroundSurface() => darkMode()
      ? darkColorScheme.surface.darken(50)
      : lightColorScheme.surface.darken(5);

  static Color material(MaterialColor c) =>
      darkMode() ? c.shade100 : c.shade700;

  static Color onMaterial(MaterialColor c) =>
      darkMode() ? c.shade900 : c.shade50;

  static Color materialContainer(MaterialColor c) =>
      darkMode() ? c.shade700 : c.shade100;

  static Color onMaterialContainer(MaterialColor c) =>
      darkMode() ? c.shade50 : c.shade900;
}
