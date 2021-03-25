import 'package:flutter/material.dart';
import 'package:musicplayer/utils/palette_generator.dart';

///提取图片的主色调
class PickImgMainColor {

  static Future<Color> pick(
      ImageProvider imageProvider) async {
    var paletteGenerator =
    await PaletteGenerator.fromImageProvider(imageProvider,filters: <PaletteFilter>[avoidRedBlackWhitePaletteFilter]);
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      return (paletteGenerator.lightVibrantColor?.color ?? Colors.black);
    } else {
      return (null);
    }
  }
  static Future<List<Color>> pickList(
      ImageProvider imageProvider) async {
    var paletteGenerator =
    await PaletteGenerator.fromImageProvider(
      imageProvider,
        filters: <PaletteFilter>[avoidRedBlackWhitePaletteFilter]
    );
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      return (paletteGenerator.colors.toList());
    } else {
      return (null);
    }
  }

  static Future<Map<PaletteTarget,PaletteColor>> pickMap(
      ImageProvider imageProvider) async {
    var paletteGenerator =
    await PaletteGenerator.fromImageProvider(
      imageProvider,
        filters: <PaletteFilter>[avoidRedBlackWhitePaletteFilter]
    );
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      return (paletteGenerator.selectedSwatches);
    } else {
      return (null);
    }
  }

}