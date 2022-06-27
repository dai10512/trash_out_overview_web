import 'package:flutter/material.dart';

const String iOSInstallURL = 'https://apple.co/3zMRxsu';
const String androidInstallURL = 'https://play.google.com/store/apps/details?id=com.me.trash_out';
const String contactUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfK3Atlu_Gljy2K4VuSRbNQNXN8oHR3AdywsQjqRYFs8rKOjg/viewform';

const double commonElevation = 2;
// const Color topLeftColor = Color(0xFF007AFD);
Color? topLeftColor = Colors.blue[600];
// const Color bottomRightColor = Color(0xFFDEE1E7);
Color? bottomRightColor = Colors.blue[300];
LinearGradient commonGradient = LinearGradient(
  colors: [topLeftColor!, bottomRightColor!],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const double totalPadding = 20;

class CoolDivider extends StatelessWidget {
  const CoolDivider({
    Key? key,
    this.height = 16,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    required this.gradient,
  }) : super(key: key);

  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height),
        Container(
          height: thickness,
          margin: EdgeInsetsDirectional.only(
            start: indent,
            end: endIndent,
          ),
          decoration: BoxDecoration(gradient: commonGradient),
        ),
      ],
    );
  }
}
