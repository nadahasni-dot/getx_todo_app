import 'package:getx_todo_app/data/models/todo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();

  DatabaseService._internal();

  factory DatabaseService() {
    return _databaseService;
  }

  static DatabaseService get instance => _databaseService;
  static Isar? _instance;

  Future<Isar?> get database async {
    if (_instance != null) {
      return _instance!;
    }

    final dir = await getApplicationDocumentsDirectory();
    _instance = await Isar.open(
      [TodoSchema],
      directory: dir.path,
    );

    return _instance;
  }
}
