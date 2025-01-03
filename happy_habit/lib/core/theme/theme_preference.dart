import 'package:flutter/material.dart';
import 'package:happy_habit/core/theme/typography.dart';

import 'components_theme.dart';
import 'theme_colors.dart';

class ThemePreferences {
  static ThemeData getAppTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        canvasColor: Colors.white,
        // cardColor: ThemeColor.white,
        primaryColor: ThemeColor.primary,
        // textTheme: TypographyUtils.getTextTheme(),
        textTheme: Theme.of(context)
            .textTheme
            .apply(
              fontFamily: "TBD",
            )
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
            ),

        // themes

        // themes using context

        // colorScheme
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.light,
          cardColor: ThemeColor.secondary,
          primarySwatch: ThemeColor.primary,
          backgroundColor: ThemeColor.background,
        ).copyWith(
          brightness: Brightness.light,
          secondary: ThemeColor.secondary,
          background: ThemeColor.secondary,
        ),
        
      );
}
