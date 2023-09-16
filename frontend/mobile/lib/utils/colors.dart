import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFEAF2EB),
  100: Color(0xFFCADDCC),
  200: Color(0xFFA6C7AB),
  300: Color(0xFF82B189),
  400: Color(0xFF68A06F),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF46874F),
  700: Color(0xFF3D7C45),
  800: Color(0xFF34723C),
  900: Color(0xFF25602B),
});
const int _primaryPrimaryValue = 0xFF4D8F56;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFA4FFAE),
  200: Color(_primaryAccentValue),
  400: Color(0xFF3EFF52),
  700: Color(0xFF25FF3C),
});
const int _primaryAccentValue = 0xFF71FF80;

const MaterialColor background =
    MaterialColor(_backgroundPrimaryValue, <int, Color>{
  50: Color(0xFFFDFDFD),
  100: Color(0xFFFBFBFB),
  200: Color(0xFFF9F9F9),
  300: Color(0xFFF6F6F6),
  400: Color(0xFFF4F4F4),
  500: Color(_backgroundPrimaryValue),
  600: Color(0xFFF0F0F0),
  700: Color(0xFFEEEEEE),
  800: Color(0xFFECECEC),
  900: Color(0xFFE8E8E8),
});
const int _backgroundPrimaryValue = 0xFFF2F2F2;

const MaterialColor backgroundAccent =
    MaterialColor(_backgroundAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_backgroundAccentValue),
  400: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
});
const int _backgroundAccentValue = 0xFFFFFFFF;
