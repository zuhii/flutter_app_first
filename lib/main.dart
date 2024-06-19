import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:toonflix/controller/pref_controller.dart';
import 'package:toonflix/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final PrefController pref = Get.put(PrefController());
    return Obx(() {
      return GetMaterialApp(
        theme: pref.themeMode.value == 'light'
            ? ThemeData.light()
            : ThemeData.dark(),
        home: const HomeScreen(),
      );
    });
  }
}
