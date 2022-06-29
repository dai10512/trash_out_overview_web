import 'dart:html';

import 'package:flutter/material.dart';

// Url
String iOSInstallURL = 'https://apple.co/3zMRxsu';
String androidInstallURL = 'https://play.google.com/store/apps/details?id=com.me.trash_out';
String contactUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfK3Atlu_Gljy2K4VuSRbNQNXN8oHR3AdywsQjqRYFs8rKOjg/viewform';

// color
Color? topLeftColor = Colors.blue[600];
Color? bottomRightColor = Colors.blue[300];
Color cardTextColor = Colors.white;

// gradientColor
LinearGradient commonGradient = LinearGradient(
  colors: [topLeftColor!, bottomRightColor!],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

LinearGradient cardGradient = LinearGradient(
  colors: [topLeftColor!.withOpacity(0.5), bottomRightColor!.withOpacity(0.5)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// others
double totalPadding = 20;
double minMonitorWidth = 1000;
double commonElevation = 20;
