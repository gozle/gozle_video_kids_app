import 'package:flutter/material.dart';

class InkWrapper extends StatelessWidget {
  final Color? splashColor;
  final BorderRadius? borderRadius;
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;

  const InkWrapper({
    super.key,
    this.splashColor,
    this.borderRadius,
    required this.child,
    required this.onTap,
    this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromRGBO(9, 9, 9, 0.295),
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      child: InkWell(
        overlayColor: MaterialStatePropertyAll(Colors.black45),
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        splashColor: splashColor,
        onTap: onTap,
        child: child,
        onDoubleTap: onDoubleTap,
      ),
    );
  }
}
