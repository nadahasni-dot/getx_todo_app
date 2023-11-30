import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/routes/app_routes.dart';
import 'package:getx_todo_app/screens/login_screen.dart';
import 'package:getx_todo_app/screens/settings_screen.dart';
import 'package:getx_todo_app/screens/todo_screen.dart';

@immutable
class AppPages {
  static List<GetPage<dynamic>>? getPages = [
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.todoScreen,
      page: () => const TodoScreen(),
    ),
    GetPage(
      name: AppRoutes.settingsScreen,
      page: () => const SettingsScreen(),
    ),
  ];
}
