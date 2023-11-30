import 'dart:developer';

import 'package:getx_todo_app/data/local/database_service.dart';
import 'package:getx_todo_app/data/models/todo.dart';
import 'package:isar/isar.dart';

class TodoRepository {
  static const _tag = 'TODO REPOSITORY';

  Future<List<Todo>> getAllTodos() async {
    try {
      final db = await DatabaseService.instance.database;

      final todos = await db?.txn<List<Todo>>(() async {
        return await db.todos.where().findAll();
      });

      return todos ?? [];
    } catch (e) {
      log(e.toString(), name: _tag);
      rethrow;
    }
  }

  Future<void> putTodo(Todo todo) async {
    try {
      final db = await DatabaseService.instance.database;
      await db?.writeTxn(() async {
        return await db.todos.put(todo);
      });
    } catch (e) {
      log(e.toString(), name: _tag);
      rethrow;
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      final db = await DatabaseService.instance.database;
      await db?.writeTxn(() async {
        return await db.todos.delete(todo.id);
      });
    } catch (e) {
      log(e.toString(), name: _tag);
      rethrow;
    }
  }

  Future<void> clearAllTodos() async {
    try {
      final db = await DatabaseService.instance.database;
      await db?.writeTxn(() async {
        return await db.todos.where().deleteAll();
      });
    } catch (e) {
      log(e.toString(), name: _tag);
      rethrow;
    }
  }
}
