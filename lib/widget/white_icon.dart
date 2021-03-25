import 'package:flutter/material.dart';

class WhiteIcon extends StatelessWidget {
  final IconData iconData;

  const WhiteIcon(this.iconData,{Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: Colors.white.withOpacity(0.5),
      size: 26,
    );
  }
}
