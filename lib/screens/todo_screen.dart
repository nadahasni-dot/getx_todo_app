import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/todo_controller.dart';
import 'package:getx_todo_app/data/models/todo.dart';
import 'package:getx_todo_app/routes/app_routes.dart';
import 'package:getx_todo_app/widgets/create_todo_sheet.dart';
import 'package:getx_todo_app/widgets/todo_info.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoController todoController = Get.put(TodoController());

  @override
  void initState() {
    super.initState();
    todoController.getAllTodos();
  }

  void _navigateToSettings() {
    Get.toNamed(AppRoutes.settingsScreen);
  }

  void _toggleTodo(Todo todo, bool isDone) {
    todo.isDone = isDone;
    todoController.updateTodo(todo);
  }

  _deleteTodo(Todo todo) {
    todoController.deleteTodo(todo);
  }

  void _openCreateSheet() {
    Get.bottomSheet(const CreateTodoSheet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          IconButton(
            onPressed: _navigateToSettings,
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateSheet,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TodoInfo(),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Expanded(
            child: Obx(() {
              if (todoController.getTodoRequestStatus.value ==
                  RequestStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (todoController.getTodoRequestStatus.value ==
                  RequestStatus.failed) {
                return Center(child: Text('fetch_data_failed'.tr));
              }

              return ListView.separated(
                itemCount: todoController.todos.length,
                itemBuilder: (context, index) {
                  final todo = todoController.todos[index];

                  return Slidable(
                    key: ValueKey(todo.id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => _deleteTodo(todo),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'delete'.tr,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        todo.todo ?? '-',
                        style: TextStyle(
                          decoration: todo.isDone == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Checkbox(
                        onChanged: (value) => _toggleTodo(todo, value ?? false),
                        value: todo.isDone ?? false,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
