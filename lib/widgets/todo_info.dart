import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/todo_controller.dart';

class TodoInfo extends StatelessWidget {
  const TodoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.find<TodoController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('done'
                .trParams({'value': todoController.countTodosDone.toString()})),
            Text('waiting'.trParams(
                {'value': todoController.countTodosWaiting.toString()})),
            Text('all'
                .trParams({'value': todoController.todos.length.toString()})),
          ],
        );
      }),
    );
  }
}
