import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:hello_flutter/login_signup/login_page.dart';
import 'package:hello_flutter/navitaions/home_menu.dart';
import 'package:hello_flutter/navitaions/music_menu.dart';
import 'package:hello_flutter/navitaions/news_menu.dart';
import 'package:hello_flutter/navitaions/side_navigation/favouride.dart';
import 'package:hello_flutter/navitaions/side_navigation/friends.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final RxInt _currInd = 0.obs;
  final RxInt _bottomVarIndex = 0.obs;
  final List<Widget> pages = [
    const HomeMenu(),
    const MusicMenu(),
    NewsMenu(),
    const Favourite(),
    const Friends(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        onItemSelected: (ind) {
          if (ind != 9) {
            _currInd.value = ind;
          }
        },
      ),
      appBar: AppBar(
        title: const Text(
          "Welcome",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();

                  sharedPreferences.remove("islog");
                  Get.offAll(LoginPage());
                },
              ),
              const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() => pages[_currInd.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: _bottomVarIndex.value,
          backgroundColor: Colors.blue,
          onTap: (index) {
            _bottomVarIndex.value = index;
            _currInd.value = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: "Music",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: "News",
            ),
          ],
        ),
      ),
    );
  }
}
