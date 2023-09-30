import 'package:flutter/widgets.dart';

class StylesHelpers {
  /// Base style
  static _baseStyle(FontWeight fontWeight, [Color? color, double? size]) {
    return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Style with [FontWeight.w400]
  static w400(double size, [Color? color]) {
    return _baseStyle(FontWeight.w400, color, size);
  }

  /// Style with [FontWeight.w500]
  static w500(double size, [Color? color]) {
    return _baseStyle(FontWeight.w500, color, size);
  }

  /// Style with [FontWeight.w600]
  static w600(double size, [Color? color]) {
    return _baseStyle(FontWeight.w600, color, size);
  }

  /// Style with [FontWeight.w700]
  static w700(double size, [Color? color]) {
    return _baseStyle(FontWeight.w700, color, size);
  }
}
