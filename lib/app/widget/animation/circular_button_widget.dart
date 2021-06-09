import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function? onClick;
  final AnimatedIconData buttonAnimatedIconData;

  const CircularButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.color,
      required this.icon,
      this.onClick,
      this.buttonAnimatedIconData = AnimatedIcons.menu_close})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(
          icon: icon,
          enableFeedback: true,
          onPressed: () {
            onClick!();
          }),
    );
  }
}
