import 'package:flutter/material.dart';
import 'package:ird_task/core/common/styles/global_text_style.dart';

class CoustomTextButton extends StatefulWidget {
  const CoustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.textSize,
    this.fontWeight,
  });

  final String text;
  final Color? textColor;
  final double? textSize;
  final Function onTap;
  final FontWeight? fontWeight;

  @override
  State<CoustomTextButton> createState() => _CoustomTextButtonState();
}

class _CoustomTextButtonState extends State<CoustomTextButton> {
  late Color color;
  late double size;

  @override
  void initState() {
    super.initState();
    color = widget.textColor ?? Colors.white;
    size = widget.textSize ?? 14.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Text(widget.text, style: getTextStyle(color: color)),
    );
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      color = color.withOpacity(0.6);
    });
  }

  void _onTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 150)).then((value) {
      setState(() {
        color = widget.textColor ?? Colors.white;
        size = widget.textSize ?? 14.0;
      });
    });
  }
}
