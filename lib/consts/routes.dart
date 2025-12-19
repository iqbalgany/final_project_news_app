import 'package:final_project_news_app/models/news_model.dart';
import 'package:final_project_news_app/pages/auth/login_page.dart';
import 'package:final_project_news_app/pages/auth/signup_page.dart';
import 'package:final_project_news_app/pages/main_menu_page.dart';
import 'package:final_project_news_app/pages/news/news_detail_page.dart';
import 'package:final_project_news_app/pages/news/news_page.dart';
import 'package:final_project_news_app/pages/profile/profile_page.dart';
import 'package:final_project_news_app/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String mainMenu = '/main-menu';
  static const String news = '/news';
  static const String newsDetail = '/news-detail';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

final routes = {
  AppRoutes.login: (context) => LoginPage(),
  AppRoutes.signup: (context) => SignupPage(),
  AppRoutes.mainMenu: (context) => MainMenuPage(),
  AppRoutes.news: (context) => NewsPage(),
  AppRoutes.newsDetail: (context) {
    final args = ModalRoute.of(context)!.settings.arguments as NewsModel;
    return NewsDetailPage(news: args);
  },
  AppRoutes.profile: (context) => ProfilePage(),
  AppRoutes.settings: (context) => SettingsPage(),
};
