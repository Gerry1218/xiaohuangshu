import 'dart:ui';

import 'package:flutter/material.dart';

// Color
const Color colorFA = Color(0xfffafafa);
const Color color26 = Color(0xff262626);
const Color colorF5 = Color(0xfff5f5f5);
const Color colorDC = Color(0xffdcdcdc);
const Color color33 = Color(0xff333333);
const Color colorEB4C41 = Color(0xffEB4C41);
const Color colorE5 = Color(0xffE5E5E5);
const Color colorF44C40 = Color(0xffF44C40);
const Color color16 = Color(0xff161616);
const Color color666 = Color(0xff666666);
const Color color999 = Color(0xff999999);
const Color colorF1 = Color(0xfff1f1f1);
const Color color4C = Color(0xff4C4C4C);



// TextStyle
TextStyle tsViewCount = TextStyle(color: Colors.grey[600], fontSize: 13);

TextStyle tsUserName =
    TextStyle(color: Colors.grey.shade600, fontSize: 11, letterSpacing: 0.3);

TextStyle tsUserName14 =
    const TextStyle(color: Colors.black54, fontSize: 14, letterSpacing: 0.3);

const TextStyle tsContent = TextStyle(
    fontWeight: FontWeight.w600,
    color: color26,
    fontSize: 12,
    letterSpacing: 0.5);

const TextStyle tsFollow = TextStyle(
    color: colorEB4C41,
    fontSize: 14,
    letterSpacing: 3,
    fontWeight: FontWeight.w600);

const TextStyle tsNumber = TextStyle(
    fontSize: 13,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6);

// Icon
const Icon iconFav = Icon(
  Icons.favorite,
  size: 15,
  color: Colors.red,
);

// BorderRadius
const BorderRadius brTopLR8 = BorderRadius.only(
    topLeft: Radius.circular(8), topRight: Radius.circular(8));
