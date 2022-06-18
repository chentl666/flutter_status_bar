import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterStatusBar {
  static const MethodChannel _channel =
      const MethodChannel('com.ctl.plugins/flutterstatusbar');

  /// 获取状态栏背景色
  static Future<Color?> getStatusBarColor() =>
      _channel.invokeMethod('getstatusbarcolor').then((dynamic value) {
        return value == null ? null : Color(value);
      });

  /// 设置状态栏背景色
  static Future<void> setStatusBarColor(
    Color color, {
    bool animate = false,
  }) =>
      _channel.invokeMethod('setstatusbarcolor', {
        'color': color.value,
        'animate': animate,
      });

  /// 设置文字和图标的颜色
  /// true 白色
  /// false 黑色
  static Future<void> setStatusBarWhiteForeground(bool useWhiteForeground) =>
      _channel.invokeMethod('setstatusbarwhiteforeground', {
        'whiteForeground': useWhiteForeground,
      });

  /// 只用于 Android
  ///
  /// 获取导航栏背景色
  static Future<Color?> getNavigationBarColor() =>
      _channel.invokeMethod('getnavigationbarcolor').then((dynamic value) {
        return value == null ? null : Color(value);
      });

  /// 只用于 Android
  ///
  /// 设置导航栏背景色
  /// 透明度将被忽略
  static Future<void> setNavigationBarColor(
    Color color, {
    bool animate = false,
  }) =>
      _channel.invokeMethod('setnavigationbarcolor', {
        'color': color.value,
        'animate': animate,
      });

  /// 只用于 Android
  ///
  /// 设置导航图标的颜色
  /// true 白色
  /// false 黑色
  static Future<void> setNavigationBarWhiteForeground(
          bool useWhiteForeground) =>
      _channel.invokeMethod('setnavigationbarwhiteforeground', {
        'whiteForeground': useWhiteForeground,
      });

  ///设置全屏，隐藏状态栏和导航栏
  static setFullscreen(bool value) {
    if (kIsWeb) return;
    if (value) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }
}

/// 帮助您选择黑色或白色前景色
bool useWhiteForeground(Color backgroundColor) =>
    1.05 / (backgroundColor.computeLuminance() + 0.05) > 4.5;
