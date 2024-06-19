import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefController extends GetxController {
  RxString themeMode = 'light'.obs;

  Future<void> setThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', mode);
    themeMode.value = mode;
    debugPrint('${getThemeMode()}');
  }

  Future getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('themeMode') != null) {
      themeMode.value = prefs.getString('themeMode')!;
    } else {
      setThemeMode('light');
    }
    return themeMode.value;
  }
}
