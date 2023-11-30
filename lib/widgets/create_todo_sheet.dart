import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/todo_controller.dart';

class CreateTodoSheet extends StatefulWidget {
  const CreateTodoSheet({super.key});

  @override
  State<CreateTodoSheet> createState() => _CreateTodoSheetState();
}

class _CreateTodoSheetState extends State<CreateTodoSheet> {
  final TodoController todoController = Get.put(TodoController());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController inputTodo = TextEditingController();

  void _saveTodo() async {
    if (!formKey.currentState!.validate()) return;

    await todoController.createTodo(inputTodo.text);

    inputTodo.clear();
    Get.until((route) => !Get.isBottomSheetOpen!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: inputTodo,
                  decoration: InputDecoration(
                    hintText: 'todo_hint'.tr,
                  ),
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return 'cannot_empty'.tr;
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _saveTodo,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: Text('save'.tr),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
