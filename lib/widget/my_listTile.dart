import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatefulWidget {
  final double left;
  final double right;
  final double top;
  final double bottom;
  final double betweenLeadingAndCenter;
  final double betweenCenterAndTrailing;
  final Widget leading;
  final Widget center;
  final Widget trailing;
  final GestureTapCallback onTap;
  final GestureDoubleTapCallback onDoubleTap;
  final CrossAxisAlignment crossAxis;
  const MyListTile(
      {Key key,
        this.left = 0,
        this.right = 0,
        this.top = 0,
        this.bottom = 0,
        this.leading,
        this.center,
        this.trailing,
        this.onTap,
        this.onDoubleTap,
        this.betweenLeadingAndCenter = 10,
        this.betweenCenterAndTrailing = 10,
        this.crossAxis = CrossAxisAlignment.start})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyListTileState();
  }
}

class _MyListTileState extends State<MyListTile> {

  @override
  Widget build(BuildContext context) {
    

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(
          top:  widget.top,
          bottom: widget.bottom,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(child: widget.leading),
            SizedBox(width: widget.betweenLeadingAndCenter),
            Expanded(child: Container(child: widget.center)),
            SizedBox(width: widget.betweenCenterAndTrailing),
            Container(
                child: widget.trailing),
          ],
        ),
      ),
    );
  }
}