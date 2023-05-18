import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.label,
      required this.fontsize,
      this.color,
      this.fontweight});
  final String label;
  final double fontsize;
  final Color? color;
  final FontWeight? fontweight;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontsize,
          fontWeight: fontweight),
    );
  }
}
