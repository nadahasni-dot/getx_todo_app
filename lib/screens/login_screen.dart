import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/data/local/local_storage.dart';
import 'package:getx_todo_app/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();

  void _doSignIn() async {
    if (!formKey.currentState!.validate()) return;

    await LocalStorage.saveSession();
    Get.offAllNamed(AppRoutes.todoScreen);
  }

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'email'),
                validator: (value) {
                  if (value.toString().trim().isEmpty) return 'cannot_empty'.tr;
                  if (!GetUtils.isEmail(value.toString())) {
                    return 'email_error'.tr;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: !isPasswordVisible,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: 'password',
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                validator: (value) {
                  if (value.toString().trim().isEmpty) return 'cannot_empty'.tr;
                  if (GetUtils.isNumericOnly(value.toString())) {
                    return 'password_error'.tr;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _doSignIn,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                child: Text('sign_in'.tr),
              )
            ],
          ),
        ),
      ),
    );
  }
}
