import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/app_controller.dart';
import 'package:getx_todo_app/data/local/local_storage.dart';
import 'package:getx_todo_app/i18n/localization_translations.dart';
import 'package:getx_todo_app/routes/app_pages.dart';
import 'package:getx_todo_app/routes/app_routes.dart';

bool isSignedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  isSignedIn = await LocalStorage.checkIsLogin();
  log('IS SIGNED IN: $isSignedIn');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    controller.loadPreferredLocale();
    controller.loadPreferredTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'GetX Todo App',
        locale: controller.preferredLocale.value,
        fallbackLocale: const Locale('id', 'ID'),
        getPages: AppPages.getPages,
        initialRoute: isSignedIn ? AppRoutes.todoScreen : AppRoutes.loginScreen,
        translations: LocalizationTranslations(),
        theme: ThemeData.light(useMaterial3: false),
        darkTheme: ThemeData.dark(useMaterial3: false),
        themeMode:
            controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      );
    });
  }
}
