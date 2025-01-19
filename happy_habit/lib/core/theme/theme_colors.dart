import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeColor {
  static const secondary = Colors.white;
  static const primaryV2 = Color(0xFFFFDA58);
  // static const background = Color(0xffF2F2F2);
  static const background = Color(0xffaee8fe);
  static const primaryShade = Color(0xFFFFF3E8);

  static const hint = Color(0xFF656464);
  static const border = Color(0xFFE9E9E9);
  static const fontBlack = Color(0xFF4D4D4D);

  static const vividGreen = Color(0xff02CE76);
  static const graphiteGrey = Color(0xff8F8F8F);
  static const error = CupertinoColors.systemRed;
  static const success = CupertinoColors.activeGreen;

  // Primary color (#FF944C)
  static const int _primaryColorValue = 0xFFFF944C;
  static const MaterialColor primary = MaterialColor(
    _primaryColorValue,
    <int, Color>{
      50: Color(0xFFFFF3E8),
      100: Color(0xFFFFE0C2),
      200: Color(0xFFFFCC99),
      300: Color(0xFFFFB770),
      400: Color(0xFFFFA955),
      500: Color(0xFFFF944C),
      600: Color(0xFFEB8645),
      700: Color(0xFFD6773D),
      800: Color(0xFFC26836),
      900: Color(0xFFA65129),
    },
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFDA58), // #FFDA58
      Color(0xFFFF924D), // #FF924D
    ],
  );
}

class AvatarColors {
  static const List<String> colors = [
    '#2D2317',
    '#2D2017',
    '#2D1918',
    '#E3C088',
    '#E3B788',
    '#F2E1C3',
    '#573823',
    '#552D25',
    '#E1A895',
    '#EDC399',
    '#F4DEC5',
    '#72593B',
    '#79563A',
    '#74453B',
    '#EBBAA7',
    '#F3DCBC',
    '#F1D6BB',
    '#886E49',
    '#8A6646',
    '#8C5F4C',
    '#F2CFBB',
    '#A98A5C',
    '#A8805D',
    '#A27162',
    '#FAE3DD',
  ];
}
