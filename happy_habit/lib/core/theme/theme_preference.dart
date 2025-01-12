import 'package:flutter/material.dart';
import 'package:happy_habit/core/services/utils.dart';
import 'package:happy_habit/core/theme/components_theme.dart';
import 'package:happy_habit/core/theme/typography.dart';

import 'theme_colors.dart';

class ThemePreferences {
  static ThemeData getAppTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        canvasColor: Colors.white,
        primaryColor: ThemeColor.primary,
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(
              labelLarge: context.labelLarge,
              labelMedium: context.labelMedium,
              labelSmall: context.labelSmall,
              bodyLarge: context.bodyLarge,
              bodyMedium: context.bodyMedium,
              bodySmall: context.bodySmall,
              titleLarge: context.titleLarge,
              titleMedium: context.titleMedium,
              titleSmall: context.titleSmall,
              headlineLarge: context.headlineLarge,
              headlineMedium: context.headlineMedium,
              headlineSmall: context.headlineSmall,
              displayLarge: context.displayLarge,
              displayMedium: context.displayMedium,
              displaySmall: context.displaySmall,
            )
            .apply(
              fontFamily: Utils.kFontFamily,
              bodyColor: ThemeColor.fontBlack, // Apply fontBlack to text
              displayColor: ThemeColor.fontBlack, // Apply fontBlack to display tex
            ),
        // themes
        cardTheme: ComponentsTheme.cardTheme,
        iconTheme: ComponentsTheme.iconThemeData,
        dividerTheme: ComponentsTheme.dividerTheme,

        // themes using context
        dialogTheme: ComponentsTheme.dialogTheme(context),
        appBarTheme: ComponentsTheme.appBarTheme(context),
        tabBarTheme: ComponentsTheme.tabBarTheme(context),
        switchTheme: ComponentsTheme.switchThemeData(context),
        searchBarTheme: ComponentsTheme.searchBarTheme(context),
        elevatedButtonTheme: ComponentsTheme.elevatedButtonTheme(context),
        outlinedButtonTheme: ComponentsTheme.outlinedButtonTheme(context),
        inputDecorationTheme: ComponentsTheme.inputDecorationTheme(context),

        // colorScheme
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.light,
          cardColor: ThemeColor.secondary,
          primarySwatch: ThemeColor.primary,
          backgroundColor: ThemeColor.background,
        ).copyWith(
          brightness: Brightness.light,
          surface: ThemeColor.secondary,
          secondary: ThemeColor.secondary,
        ),
      );
}
