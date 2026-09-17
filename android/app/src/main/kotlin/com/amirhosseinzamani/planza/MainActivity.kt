package com.amirhosseinzamani.planza

import android.content.Context
import android.content.SharedPreferences
import android.os.Environment
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val PATH_CHANNEL = "planza/paths"
    private val PREFS_CHANNEL = "planza/shared_preferences"
    private val PREFS_NAME = "planza_prefs"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PATH_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getApplicationDocumentsDirectory" -> {
                    val dir = applicationContext.getFilesDir()
                    result.success(dir.absolutePath)
                }
                "getApplicationSupportDirectory" -> {
                    val dir = applicationContext.getDir("database", Context.MODE_PRIVATE)
                    result.success(dir.absolutePath)
                }
                "getTemporaryDirectory" -> {
                    val dir = applicationContext.cacheDir
                    result.success(dir.absolutePath)
                }
                else -> result.notImplemented()
            }
        }
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PREFS_CHANNEL).setMethodCallHandler { call, result ->
            val prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            when (call.method) {
                "getAll" -> {
                    val all = prefs.all
                    result.success(all)
                }
                "setString" -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = call.argument<String>("value") ?: ""
                    prefs.edit().putString(key, value).apply()
                    result.success(true)
                }
                "setBool" -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = call.argument<Boolean>("value") ?: false
                    prefs.edit().putBoolean(key, value).apply()
                    result.success(true)
                }
                "setInt" -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = call.argument<Int>("value") ?: 0
                    prefs.edit().putInt(key, value).apply()
                    result.success(true)
                }
                "setDouble" -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = call.argument<Double>("value") ?: 0.0
                    prefs.edit().putFloat(key, value.toFloat()).apply()
                    result.success(true)
                }
                "setStringList" -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = call.argument<List<String>>("value") ?: emptyList()
                    prefs.edit().putStringSet(key, value.toSet()).apply()
                    result.success(true)
                }
                "remove" -> {
                    val key = call.argument<String>("key") ?: ""
                    prefs.edit().remove(key).apply()
                    result.success(true)
                }
                "clear" -> {
                    prefs.edit().clear().apply()
                    result.success(true)
                }
                "getAll" -> {
                    val all = prefs.all
                    result.success(all)
                }
                else -> result.notImplemented()
            }
        }
    }
}