import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/app_controller.dart';
import 'package:getx_todo_app/controllers/todo_controller.dart';
import 'package:getx_todo_app/data/local/local_storage.dart';
import 'package:getx_todo_app/routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AppController appController = Get.find<AppController>();
  final TodoController todoController = Get.find<TodoController>();

  void _onThemeChange(bool isDark) async {
    Get.changeTheme(isDark
        ? ThemeData.dark(useMaterial3: false)
        : ThemeData.light(useMaterial3: false));
    appController.changeTheme(isDark);
  }

  void _onChangeLanguage(String language) {
    appController.changePreferredLocale(language);
  }

  void _signOut() async {
    await LocalStorage.clearSession();
    await todoController.clearAllTodos();
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: ListView(
        children: [
          Obx(() {
            return ListTile(
              title: Text('dark_mode'.tr),
              subtitle: Text(appController.isDarkMode.value
                  ? 'dark_theme'.tr
                  : 'light_theme'.tr),
              trailing: Switch(
                onChanged: _onThemeChange,
                value: appController.isDarkMode.value,
              ),
            );
          }),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('language_selections'.tr),
          ),
          Obx(() {
            return ListTile(
              title: const Text('English US'),
              onTap: () => _onChangeLanguage('en'),
              trailing: Checkbox(
                value: appController.preferredLocale.value
                    .toString()
                    .contains('en'),
                onChanged: (value) => {},
              ),
            );
          }),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Obx(() {
            return ListTile(
              title: const Text('Indonesian'),
              onTap: () => _onChangeLanguage('id'),
              trailing: Checkbox(
                value: appController.preferredLocale.value
                    .toString()
                    .contains('id'),
                onChanged: (value) => {},
              ),
            );
          }),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            onTap: _signOut,
            title: Text('sign_out'.tr),
            subtitle: Text('sign_out_desc'.tr),
            trailing: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.exit_to_app_rounded),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
