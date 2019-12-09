import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'lottie_controller.dart';

enum ScaleType {
  MATRIX, // 0
  FIT_XY, // 1,
  FIT_START, // 2
  FIT_CENTER, // (3)
  FIT_END, // (4)
  CENTER, // (5)
  CENTER_CROP, // (6)
  CENTER_INSIDE // (7)
}

typedef void LottieViewCreatedCallback(LottieController controller);

class LottieView extends StatefulWidget {

  LottieView.fromURL({
    @required this.onViewCreated,
    @required this.url,
    Key key,
    this.loop = false,
    this.autoPlay,
    this.reverse,
    this.scale,
    this.scaleType,
    this.translateX,
    this.translateY
  }) : this.filePath = null, super(key: key);

  LottieView.fromFile({
    Key key,
    @required this.onViewCreated,
    @required this.filePath,
    this.loop = false,
    this.autoPlay,
    this.reverse,
    this.scale,
    this.scaleType,
    this.translateX,
    this.translateY
  }) : this.url = null, super(key: key);

  final bool loop;
  final bool autoPlay;
  final bool reverse;
  final double scale;
  final ScaleType scaleType;
  final double translateX;
  final double translateY;
  final String url;
  final String filePath;

  @override
  _LottieViewState createState() => _LottieViewState();

  final LottieViewCreatedCallback onViewCreated;
}

class _LottieViewState extends State<LottieView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'convictiontech/flutter_lottie',
        creationParams: <String, dynamic>{
          "url": widget.url,
          "filePath": widget.filePath,
          "loop": widget.loop,
          "reverse": widget.reverse,
          "autoPlay": widget.autoPlay,
          "scale": widget.scale,
          "scaleType": widget.scaleType.index,
          "translateX": widget.translateX,
          "translateY": widget.translateY
        },
        creationParamsCodec: StandardMessageCodec(),
        onPlatformViewCreated: onPlatformCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'convictiontech/flutter_lottie',
        creationParams: <String, dynamic>{
          "url": widget.url,
          "filePath": widget.filePath,
          "loop": widget.loop,
          "reverse": widget.reverse,
          "autoPlay": widget.autoPlay,
          "scale": widget.scale,
          "scaleType": widget.scaleType.index,
          "translateX": widget.translateX,
          "translateY": widget.translateY
        },
        creationParamsCodec: StandardMessageCodec(),
        onPlatformViewCreated: onPlatformCreated,
      );
    }

    return new Text('$defaultTargetPlatform is not yet supported by this plugin');
  }

  Future<void> onPlatformCreated(id) async {
    if (widget.onViewCreated == null) {
      return;
    }
    widget.onViewCreated(new LottieController(id));
  }

}