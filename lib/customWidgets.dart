
import 'package:flutter/material.dart';
import 'package:trash_out_overview_web/util.dart';

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
