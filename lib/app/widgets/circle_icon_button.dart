import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final Widget icon;
  final BoxBorder? border;
  final EdgeInsetsGeometry padding;
  final Color iconColor;
  final double iconSize;
  final Color backgroundColor;
  final Function()? onPressed;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? focusColor;

  const CircleIconButton({
    Key? key,
    required this.icon,
    this.border,
    this.padding = const EdgeInsets.all(10),
    this.iconColor = Colors.black,
    this.iconSize = 24,
    this.backgroundColor = Colors.transparent,
    this.onPressed,
    this.hoverColor,
    this.splashColor,
    this.highlightColor,
    this.focusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Important: Removing the indicated lines the icon begins to move on hover

    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: Center(
        child: Ink(
          decoration: ShapeDecoration(
            color: backgroundColor, // Do not remove this line
            shape: const CircleBorder(),
          ),
          child: Container(
            // Do not remove these lines
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: border,
            ),
            child: IconButton(
              icon: icon,
              color: iconColor,
              iconSize: iconSize,
              hoverColor: hoverColor,
              splashColor: splashColor,
              highlightColor: highlightColor,
              focusColor: focusColor,
              padding: padding,
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }
}
