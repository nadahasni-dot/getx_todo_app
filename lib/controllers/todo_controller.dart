import 'package:get/get.dart';
import 'package:getx_todo_app/data/models/todo.dart';
import 'package:getx_todo_app/data/repositories/todo_repository.dart';

enum RequestStatus { loading, success, failed }

class TodoController extends GetxController {
  Rx<RequestStatus> getTodoRequestStatus = RequestStatus.loading.obs;
  RxList<Todo> todos = <Todo>[].obs;
  TodoRepository todoRepository = TodoRepository();

  int get countTodosDone => todos.where((todo) => todo.isDone == true).length;
  int get countTodosWaiting =>
      todos.where((todo) => todo.isDone == false || todo.isDone == null).length;

  Future<void> getAllTodos() async {
    getTodoRequestStatus.value = RequestStatus.loading;
    try {
      todos.value = await todoRepository.getAllTodos();
      getTodoRequestStatus.value = RequestStatus.success;
    } catch (e) {
      todos.clear();
      getTodoRequestStatus.value = RequestStatus.failed;
    }
  }

  Future<bool> createTodo(String text) async {
    try {
      Todo todo = Todo()
        ..todo = text
        ..isDone = false;
      await todoRepository.putTodo(todo);

      getAllTodos();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTodo(Todo todo) async {
    try {
      await todoRepository.putTodo(todo);

      getAllTodos();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTodo(Todo todo) async {
    try {
      await todoRepository.deleteTodo(todo);

      getAllTodos();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearAllTodos() async {
    try {
      await todoRepository.clearAllTodos();
      return true;
    } catch (e) {
      return false;
    }
  }
}
