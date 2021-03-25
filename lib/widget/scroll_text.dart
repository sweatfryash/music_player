import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OverflowScrollText extends StatefulWidget {
  const OverflowScrollText(
      {Key key,
      this.spaceWidth = 50,
      this.scrollDuration,
      this.pauseDuration,
      @required this.text,
      @required this.textStyle,
      @required this.maxWidth})
      : super(key: key);

  final String text;
  final TextStyle textStyle;
  final double spaceWidth;
  final double maxWidth;
  final Duration scrollDuration;
  final Duration pauseDuration;

  @override
  _OverflowScrollTextState createState() => _OverflowScrollTextState();
}

class _OverflowScrollTextState extends State<OverflowScrollText> {
  ScrollController _scrollController = ScrollController();
  Timer _timer;
  double targetPosition;
  Duration get _scrollDuration => widget.scrollDuration ?? Duration(seconds: 10);
  Duration get _pauseDuration => widget.pauseDuration ?? Duration(seconds: 2);
  bool _scroll = false;
  @override
  void initState() {
    super.initState();
    //计算文本宽度
    final constraints = BoxConstraints(
      maxWidth: widget.maxWidth,
      minHeight: 0.0,
      minWidth: 0.0,
    );
    RenderParagraph renderParagraph = RenderParagraph(
      TextSpan(
        text: widget.text,
        style: widget.textStyle,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    renderParagraph.layout(constraints);
    double textLength = renderParagraph.getMinIntrinsicWidth(widget.textStyle.fontSize).ceilToDouble();
    //如果组件宽度大于容器宽度
    if (textLength > widget.maxWidth) {
      _scroll = true;
      targetPosition = textLength + widget.spaceWidth;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //写在这里即渲染完成后才行，直接写在initstate里，scrollController还没有绑定组件，会报错
        startTimer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      children: _scroll
          ? <Widget>[buildText(),SizedBox(width: widget.spaceWidth),buildText()]
          : <Widget>[buildText()],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Widget buildText() {
    return Text(
      widget.text,
      style: widget.textStyle,
      maxLines: 1,
    );
  }

  void startTimer() {
      Future.delayed(_pauseDuration,(){
        if(_scrollController.hasClients){
          _scrollController.animateTo(targetPosition ?? 0, duration: _scrollDuration, curve: Curves.linear);
          _timer = Timer.periodic(_scrollDuration + _pauseDuration, (timer) {
            _scrollController.jumpTo(0); //跳到头部从新开始
            _scrollController.animateTo(targetPosition ?? 0, duration: _scrollDuration, curve: Curves.linear);
          });
        }
      });
  }
}
