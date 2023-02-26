import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;
  static Map<String, ThemeMode?> themeModes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark
  };
  // late SharedPreferences prefs;

  static ThemeController get to => Get.find();

  loadThemeMode() async {
    // prefs = await SharedPreferences.getInstance();
    // String themeText = prefs.getString('theme') ?? 'system';
    Directory dir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox('preferencias', path: dir.path);
    String themeText = box.get('theme') ?? 'system';
    isDark.value = themeText == 'dark' ? true : false;
    setMode(themeText);
  }

  Future setMode(String themeText) async {
    ThemeMode? themeMode = themeModes[themeText];
    print(themeText);
    if(themeMode != null) {
      Get.changeThemeMode(themeMode);
    }
    var box = await Hive.openBox('preferencias');
    await box.put('theme', themeText);
    // prefs = await SharedPreferences.getInstance();
    // await prefs.setString('theme', themeText);
  }

  changeTheme() {
    print(isDark.value ? 'light' : 'dark' );
    setMode(isDark.value ? 'light' : 'dark');
    isDark.value = !isDark.value;
  }

}