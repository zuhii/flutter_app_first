import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/controller/pref_controller.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widget/webtoon_widget.dart';

import '../models/webtoon_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PrefController pref = Get.put(PrefController());
  late SharedPreferences prefs;
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  void initState() {
    super.initState();
    pref.getThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor:
            pref.themeMode.value == 'light' ? Colors.white : Colors.black,
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          backgroundColor:
              pref.themeMode.value == 'light' ? Colors.white : Colors.black,
          foregroundColor: Colors.green,
          title: const Text(
            "오늘의 웹툰",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: pref.themeMode.value == 'light'
                            ? const Icon(Icons.light_mode)
                            : const Icon(
                                Icons.dark_mode,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          pref.themeMode.value == 'light'
                              ? pref.setThemeMode('dark')
                              : pref.setThemeMode('light');
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: makeList(snapshot),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    });
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
