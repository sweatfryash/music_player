import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AutoWidgetMarquee extends StatefulWidget {
  const AutoWidgetMarquee(
      {Key key,
        this.spaceWidth = 50,
        this.scrollDuration = const Duration(seconds: 10),
        this.pauseDuration = const Duration(seconds: 2),
        @required this.content,
        this.alwaysScroll = false,
        this.continuously = false,
        this.period,
        @required this.maxWidth,
        this.actDelay})
      : super(key: key);

  final Widget content;
  final double maxWidth;
  //默认50
  final double spaceWidth;
  //默认10s
  final Duration scrollDuration;
  //默认2s
  final Duration pauseDuration;

  //提供的内容不超出给定额最大宽度 也 滚动，普通的marquee效果
  final bool alwaysScroll;

  //连续的滚动，不加停顿
  final bool continuously;

  ///理解为往左边消失[period]个content后停止滚动
  final int period;

  ///开始滚动前的延时，不想要需要设置0，因默认会使用[pauseDuration]
  final Duration actDelay;

  @override
  _AutoWidgetMarqueeState createState() => _AutoWidgetMarqueeState();
}

class _AutoWidgetMarqueeState extends State<AutoWidgetMarquee> {
  ScrollController _scrollController = ScrollController();
  Timer _timer;
  double targetPosition;
  Duration get _scrollDuration => widget.scrollDuration;
  Duration get _pauseDuration => widget.continuously ? Duration(seconds: 0) : widget.pauseDuration;
  Duration get _actDelay => widget.actDelay ?? widget.pauseDuration;
  int _count;
  List<Widget> contents;
  GlobalKey _contentKey = GlobalKey();

  @override
  void initState() {
    _count = widget.period;
    contents = <Widget>[Container(key: _contentKey, child: widget.content)];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double widgetLength = _contentKey.currentContext.size.width;
      if (widgetLength > widget.maxWidth || widget.alwaysScroll) {
        targetPosition = widgetLength + widget.spaceWidth;
        int repeatedCount = 1;
        if (widgetLength > widget.maxWidth) {
          repeatedCount += 1;
        } else {
          repeatedCount += widget.maxWidth ~/ (widget.spaceWidth + widgetLength) + 1;
        }
        contents.clear();
        for (int i = 0; i < repeatedCount; i++) {
          contents.add(widget.content);
          contents.add(SizedBox(width: widget.spaceWidth));
        }
        setState(() {});
        startTimer();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: contents.map((e) => e).toList());
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _scrollController.dispose();
  }

  void startTimer() {
    Future.delayed(_actDelay, () {
      if (_scrollController.hasClients) {
        _scrollController
            .animateTo(targetPosition ?? 0, duration: _scrollDuration, curve: Curves.linear);
        if(_count != null){
          _count--;
        }
        _timer = Timer.periodic(_scrollDuration + _pauseDuration, (timer) {
          if (_count != null) {
            _count--;
            if (_count == 0) {
              timer.cancel();
            }
          }
          _scrollController.jumpTo(0); //跳到头部从新开始
          _scrollController.animateTo(targetPosition ?? 0, duration: _scrollDuration, curve: Curves.linear);
        });
      }
    });
  }
}
