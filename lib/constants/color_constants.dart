import 'dart:ui';

import 'package:flutter/material.dart';

// Color
const Color colorFA = Color(0xfffafafa);
const Color color26 = Color(0xff262626);
const Color colorF5 = Color(0xfff5f5f5);
const Color colorDC = Color(0xffdcdcdc);
const Color color33 = Color(0xff333333);

// TextStyle
TextStyle tsViewCount = TextStyle(color: Colors.grey[600], fontSize: 13);
TextStyle tsUserName =
TextStyle(color: Colors.grey[600], fontSize: 11, letterSpacing: 0.3);
const TextStyle tsContent = TextStyle(fontWeight: FontWeight.w600, color: color26, fontSize: 12, letterSpacing: 0.5);

// Icon
const Icon iconFav = Icon(Icons.favorite, size: 15, color: Colors.red,);

// BorderRadius
const BorderRadius brTopLR8 = BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8));