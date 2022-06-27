import 'package:flutter/material.dart';

const String iOSInstallURL = 'https://apple.co/3zMRxsu';
const String androidInstallURL = 'https://play.google.com/store/apps/details?id=com.me.trash_out';
const String contactUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfK3Atlu_Gljy2K4VuSRbNQNXN8oHR3AdywsQjqRYFs8rKOjg/viewform';

const double commonElevation = 2;
// const Color topLeftColor = Color(0xFF007AFD);
Color? topLeftColor = Colors.lightBlue[600];
// const Color bottomRightColor = Color(0xFFDEE1E7);
Color? bottomRightColor = Colors.lightBlue[400];
LinearGradient commonGradient = LinearGradient(
  colors: [topLeftColor!, bottomRightColor!],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const double totalPadding = 15;
