import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_size/app_size.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

final ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.primary, // primary
    selectionColor: AppColors.primary.withValues(alpha: 0.3), // light highlight
    selectionHandleColor: AppColors.primary, // drag handle
  ),
  bottomAppBarTheme: BottomAppBarThemeData(
    color: AppColorsDark.cardColor,
    surfaceTintColor: Colors.transparent,
    elevation: 8,
  ),
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.light(
    shadow: Colors.black.withValues(alpha: 0.2),
    brightness: Brightness.light,
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryContainer,
    onPrimary: AppColors.onPrimary,
    error: AppColors.errorColor,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.secondaryContainer,
    surface: AppColors.cardColor,
    outline: AppColors.outlineColor,
    outlineVariant: AppColors.outlineVariantColor,
    onSurface: AppColors.textColor,
    onSurfaceVariant: AppColors.placeholder,
    surfaceTint: Colors.transparent,
    tertiary: AppColors.tertiary,
    tertiaryContainer: AppColors.tertiaryContainer,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.textColor),
    titleTextStyle: TextStyle(
      color: AppColors.textColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Roboto',
    ),
  ),
  primaryColor: AppColors.primary,
  shadowColor: Colors.black.withValues(alpha: 0.2),
  dividerColor: AppColors.dividerColor,
  disabledColor: AppColors.disabledColor,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColors.cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.cornerRadius)),
    ),
  ),
  tabBarTheme: TabBarThemeData(indicatorColor: AppColors.iconColor),
  unselectedWidgetColor: AppColors.disabledColor,
  canvasColor: AppColors.canvasColor,
  cardColor: AppColors.cardColor,
  cardTheme: CardThemeData(
    color: AppColors.cardColor,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
      backgroundColor: WidgetStateProperty.all<Color?>(Colors.transparent),
      foregroundColor: WidgetStateProperty.all<Color?>(AppColors.background),
      overlayColor: WidgetStateProperty.all<Color?>(Colors.transparent),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.primary;
      return AppColors.outlineColor;
    }),
  ),
  iconTheme: IconThemeData(color: AppColors.iconColor),
  listTileTheme: ListTileThemeData(iconColor: AppColors.iconColor),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      color: AppColors.textColor,
      fontSize: 22,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      color: AppColors.textColor,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      color: AppColors.textColor,
      fontSize: 14,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: AppColors.textColor,
      fontSize: 14,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: AppColors.textColor,
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: AppColors.textColor,
      fontSize: 11,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: AppColors.textColor,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: AppColors.textColor,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: AppColors.textColor,
      fontSize: 12,
    ),
  ),
);

// final ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
//   textSelectionTheme: TextSelectionThemeData(
//     cursorColor: AppColors.primary,
//     selectionColor: AppColors.primary.withValues(alpha: 0.25),
//     selectionHandleColor: Color(0xFF239E52), // slightly darker shade
//   ),
//   colorScheme: ColorScheme.dark(
//     surface: AppColors.primaryDark,
//     primary: AppColors.primary,
//     error: theme.colorScheme.error,
//     outline: AppColors.outlineColor,
//     outlineVariant: AppColors.outlineVariantColor,
//     onSurface: AppColors.textColor,
//     onSurfaceVariant: AppColors.hintTextColor,
//     surfaceTint: Colors.transparent,
//     // tertiary: AppColors.tertiary,
//     // secondaryContainer: AppColors.tertiaryContainer,
//   ),
//   primaryColor: AppColors.primary,
//   scaffoldBackgroundColor: AppColors.primaryDark,
//   tabBarTheme: TabBarThemeData(indicatorColor: AppColors.indicatorColorLight),
//   bottomSheetTheme: BottomSheetThemeData(
//     backgroundColor: AppColors.backgroundLightDark,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.cornerRadius)),
//     ),
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     fillColor: AppColors.backgroundLightDark,
//     focusColor: AppColors.primary,
//   ),
//   cardTheme: CardThemeData(
//     color: AppColors.primary,
//     elevation: 0,
//     surfaceTintColor: Colors.transparent,
//     margin: EdgeInsets.zero,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(AppSize.inset),
//       side: BorderSide.none,
//     ),
//   ),
//   textButtonTheme: TextButtonThemeData(
//     style: ButtonStyle(
//       textStyle: WidgetStateProperty.resolveWith<TextStyle>((Set<WidgetState> states) {
//         return const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 16);
//       }),
//       padding: WidgetStateProperty.all<EdgeInsets>(
//         const EdgeInsets.fromLTRB(12, 12, 12, 12),
//       ),
//       backgroundColor: WidgetStateProperty.resolveWith<Color?>(
//         (Set<WidgetState> states) {
//           if (states.contains(WidgetState.disabled)) {
//             return AppColors.primary.withValues(alpha: 0.38);
//           }
//           return AppColors.primary;
//         },
//       ),
//       foregroundColor: WidgetStateProperty.resolveWith<Color?>(
//         (Set<WidgetState> states) {
//           if (states.contains(WidgetState.disabled)) {
//             return Colors.white.withValues(alpha: 0.38);
//           }
//           return Colors.white;
//         },
//       ),
//     ),
//   ),
//   checkboxTheme: CheckboxThemeData(
//     fillColor: WidgetStateColor.resolveWith(
//       (states) {
//         if (states.contains(WidgetState.selected)) {
//           return AppColors.primary;
//         } else {
//           return AppColors.iconColorDark;
//         }
//       },
//     ),
//   ),
//   chipTheme: ChipThemeData(selectedColor: AppColors.backgroundLightDark),
//   listTileTheme: ListTileThemeData(iconColor: AppColors.iconColorDark),
//   textTheme: const TextTheme(
//     titleLarge: TextStyle(
//       fontFamily: 'Roboto',
//       fontWeight: FontWeight.w700,
//       color: Colors.white,
//       fontSize: 20,
//     ),
//     titleMedium: TextStyle(
//       fontFamily: 'Roboto',
//       fontWeight: FontWeight.w500,
//       color: Colors.white,
//       fontSize: 16,
//     ),
//     titleSmall: TextStyle(
//       fontFamily: 'Roboto',
//       fontWeight: FontWeight.w500,
//       color: Colors.white,
//       fontSize: 14,
//     ),
//     labelLarge: TextStyle(
//       fontFamily: 'Roboto',
//       fontWeight: FontWeight.w500,
//       color: Colors.white,
//       fontSize: 14,
//     ),
//     labelMedium: TextStyle(
//       fontFamily: 'Roboto',
//       fontWeight: FontWeight.w500,
//       color: Colors.white,
//       fontSize: 12,
//     ),
//     labelSmall: TextStyle(
//       fontFamily: 'Roboto',
//       fontWeight: FontWeight.w500,
//       color: Colors.white,
//       fontSize: 11,
//     ),
//     bodyLarge: TextStyle(
//       fontFamily: 'Roboto',
//       fontWeight: FontWeight.normal,
//       color: Colors.white,
//       fontSize: 16,
//     ),
//     bodyMedium: TextStyle(
//       fontFamily: 'Roboto',
//       fontWeight: FontWeight.normal,
//       color: Colors.white,
//       fontSize: 14,
//     ),
//     bodySmall: TextStyle(
//       fontFamily: 'Roboto',
//       fontWeight: FontWeight.normal,
//       color: Colors.white,
//       fontSize: 12,
//     ),
//   ),
// );

final ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
  brightness: Brightness.dark,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColorsDark.primary,
    selectionColor: AppColorsDark.primary.withValues(alpha: 0.25),
    selectionHandleColor: AppColorsDark.primary,
  ),
  scaffoldBackgroundColor: AppColorsDark.background,
  colorScheme: ColorScheme.dark(
    shadow: Colors.black.withValues(alpha: 0.6),
    brightness: Brightness.dark,
    primary: AppColorsDark.primary,
    primaryContainer: AppColorsDark.primaryContainer,
    secondary: AppColorsDark.secondary,
    secondaryContainer: AppColorsDark.secondaryContainer,
    tertiary: AppColorsDark.tertiary,
    tertiaryContainer: AppColorsDark.tertiaryContainer,
    surface: AppColorsDark.cardColor,
    error: AppColorsDark.errorColor,
    onPrimary: Colors.black,
    onSurface: AppColorsDark.textColor,
    onSurfaceVariant: AppColorsDark.placeholder,
    outline: AppColorsDark.outlineColor,
    outlineVariant: AppColorsDark.outlineVariantColor,
    surfaceTint: Colors.transparent,
  ),
  primaryColor: AppColorsDark.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorsDark.background,
    surfaceTintColor: Colors.transparent,
  ),
  bottomAppBarTheme: BottomAppBarThemeData(
    color: AppColorsDark.homeTabBarBackgroundColor,
    surfaceTintColor: Colors.transparent,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColorsDark.cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSize.cornerRadius),
      ),
    ),
  ),
  cardColor: AppColorsDark.cardColor,
  canvasColor: AppColorsDark.background,
  cardTheme: CardThemeData(
    color: AppColorsDark.cardColor,
    surfaceTintColor: Colors.transparent,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.inset),
    ),
  ),
  dividerColor: AppColorsDark.dividerColor,
  disabledColor: AppColorsDark.disabledColor,
  iconTheme: IconThemeData(color: AppColorsDark.iconColor),
  listTileTheme: ListTileThemeData(iconColor: AppColorsDark.iconColor),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColorsDark.primary.withValues(alpha: 0.3);
          }
          return AppColorsDark.primary;
        },
      ),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColorsDark.primary;
        }
        return AppColorsDark.outlineColor;
      },
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      color: AppColorsDark.textColor,
      fontSize: 22,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      color: AppColorsDark.textColor,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      color: AppColorsDark.textColor,
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      color: AppColorsDark.textColor,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      color: AppColorsDark.textColor,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      color: AppColorsDark.textColor,
      fontSize: 12,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Roboto',
      color: AppColorsDark.textColor,
      fontSize: 14,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Roboto',
      color: AppColorsDark.textColor,
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Roboto',
      color: AppColorsDark.textColor,
      fontSize: 11,
    ),
  ),
);

extension CustomStyles on TextTheme {
  get error => (BuildContext context) => TextStyle(
        fontSize: 14.0,
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.normal,
      );

  get placeHolder => (BuildContext context) => TextStyle(
        fontSize: 12.0,
        fontFamily: "Roboto",
        color: (Theme.of(context).brightness == Brightness.dark) ? Colors.white : AppColors.textColor,
        fontWeight: FontWeight.normal,
      );
}
