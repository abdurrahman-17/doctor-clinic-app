import 'dart:math' as math;

import 'package:flutter/material.dart';

const colorPrimary = Color(0xFFbc1f26);
const colorAccent = Color(0xFFbc1f26);
const colorAccentMild = Color(0xFFffe9eb);

const colorBlack = Color(0xFF000000);
const colorWhite = Color(0xFFFFFFFF);
const colorDarkGrey = Color(0xFF808080);
const colorVeryLightGrey = Color(0xFFF0F0F0);
const colorDividerGrey = Color(0xFFD3D3D3);
const colorStarGrey = Color(0xFFD3D3D3);
const colorCloseIconImage = Color(0xFF979597);
const colorDropDownHeaderColor = Color(0xFFFDEEF2);
const colorTextContentRedColor = Color(0xFF912B36);
const colorQtyHintColor = Color(0xFF1A181A);
const colorGrey = Color(0xFFf5f5f5);
const colorYellow = Color(0xFFFFD700);
const colorYoutubeGrey = Color(0xFFF1F1F1);
const colorFbBlue = Color(0xFF3b5999);
const colorGMailRed = Color(0xFFdc4e42);
const colorTwitterBlue = Color(0xFF55acef);

const colorTextLabel = Color(0xFF7D7F7F);
const colorLightGrey = Color(0xFF91A5A6);
const colorFlashGreen = Color(0xFF46cf7d);
const colorFlashDarkGreen = Color(0xFF2ecc71);
const colorOrange = Color(0xFFED7C24);

const colorCard1 = Color(0xFF3498db);
const colorCard2 = Color(0xFFe74c3c);
const colorCard3 = Color(0xFF2ecc71);

colorRandom() => Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
