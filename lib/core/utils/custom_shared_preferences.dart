// Custom SharedPreferences implementation using MethodChannel
// This replaces the shared_preferences package

import 'dart:async';
import 'package:flutter/services.dart';

class CustomSharedPreferences {
  static const MethodChannel _channel = MethodChannel('planza/shared_preferences');
  static CustomSharedPreferences? _instance;
  final Map<String, Object> _cache = {};

  static Future<CustomSharedPreferences> getInstance() async {
    if (_instance != null) return _instance!;
    _instance = CustomSharedPreferences._();
    await _instance!._loadAll();
    return _instance!;
  }

  CustomSharedPreferences._();

  Future<void> _loadAll() async {
    try {
      final result = await _channel.invokeMapMethod<String, dynamic>('getAll');
      if (result != null) {
        final Map<dynamic, dynamic> map = result.cast<dynamic, dynamic>();
        _cache.addAll(map.cast<String, Object>());
      }
    } on PlatformException {
      // Ignore errors, use empty cache
    }
  }

  /// Gets a value from preferences
  T? get<T>(String key) {
    return _cache[key] as T?;
  }

  String? getString(String key) {
    return _cache[key] as String?;
  }

  bool? getBool(String key) {
    return _cache[key] as bool?;
  }

  int? getInt(String key) {
    return _cache[key] as int?;
  }

  double? getDouble(String key) {
    return _cache[key] as double?;
  }

  List<String>? getStringList(String key) {
    return _cache[key] as List<String>?;
  }

  /// Sets a value in preferences
  Future<bool> setString(String key, String value) async {
    try {
      await _channel.invokeMethod('setString', {'key': key, 'value': value});
      _cache[key] = value;
      return true;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> setBool(String key, bool value) async {
    try {
      await _channel.invokeMethod('setBool', {'key': key, 'value': value});
      _cache[key] = value;
      return true;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> setInt(String key, int value) async {
    try {
      await _channel.invokeMethod('setInt', {'key': key, 'value': value});
      _cache[key] = value;
      return true;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> setDouble(String key, double value) async {
    try {
      await _channel.invokeMethod('setDouble', {'key': key, 'value': value});
      _cache[key] = value;
      return true;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> setStringList(String key, List<String> value) async {
    try {
      await _channel.invokeMethod('setStringList', {'key': key, 'value': value});
      _cache[key] = value;
      return true;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> remove(String key) async {
    try {
      await _channel.invokeMethod('remove', {'key': key});
      _cache.remove(key);
      return true;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      await _channel.invokeMethod('clear');
      _cache.clear();
      return true;
    } on PlatformException {
      return false;
    }
  }

  Set<String> getKeys() {
    return _cache.keys.toSet();
  }

  bool containsKey(String key) {
    return _cache.containsKey(key);
  }

  Future<void> reload() async {
    await _loadAll();
  }
}