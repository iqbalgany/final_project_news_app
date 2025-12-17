import 'package:final_project_news_app/pages/news/news_page.dart';
import 'package:final_project_news_app/pages/profile/profile_page.dart';
import 'package:final_project_news_app/pages/settings/settings_page.dart';
import 'package:final_project_news_app/utils/colors.dart';
import 'package:flutter/material.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final pages = [NewsPage(), ProfilePage(), SettingsPage()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: currentIndex, children: pages),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _bottomNavigationBarItem('News', Icons.article, 0),
                  _bottomNavigationBarItem('Profile', Icons.person, 1),
                  _bottomNavigationBarItem('Settings', Icons.settings, 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBarItem(String title, IconData iconData, int index) {
    return GestureDetector(
      onTap: () {
        currentIndex = index;
        setState(() {});
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              color: currentIndex == index ? blueColor : Colors.transparent,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
            ),
          ),
          Icon(
            iconData,
            color: currentIndex == index ? blueColor : Colors.black54,
            size: 25,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: currentIndex == index ? blueColor : Colors.black54,
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
