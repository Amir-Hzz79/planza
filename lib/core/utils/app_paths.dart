// Built-in path provider replacement using MethodChannel
// This replaces the path_provider package

import 'dart:io';
import 'package:flutter/services.dart';

class AppPaths {
  static const MethodChannel _channel = MethodChannel('planza/paths');

  /// Gets the application documents directory
  static Future<Directory> getApplicationDocumentsDirectory() async {
    try {
      final String? path = await _channel.invokeMethod('getApplicationDocumentsDirectory');
      if (path != null) {
        return Directory(path);
      }
    } on PlatformException catch (_) {
      // Fallback to current directory if platform channel fails
    }
    // Fallback - use temp directory as fallback
    return Directory.systemTemp.createTempSync('planza_fallback');
  }

  /// Gets the application support directory (for database files)
  static Future<Directory> getApplicationSupportDirectory() async {
    try {
      final String? path = await _channel.invokeMethod('getApplicationSupportDirectory');
      if (path != null) {
        return Directory(path);
      }
    } on PlatformException catch (_) {
      // Fallback to documents directory
    }
    return getApplicationDocumentsDirectory();
  }

  /// Gets the temporary directory
  static Future<Directory> getTemporaryDirectory() async {
    try {
      final String? path = await _channel.invokeMethod('getTemporaryDirectory');
      if (path != null) {
        return Directory(path);
      }
    } on PlatformException catch (_) {
      // Fallback to system temp
    }
    return Directory.systemTemp;
  }
}