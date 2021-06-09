import 'package:minhas_anotacoes/app/model/annotation_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnnotationRepository {
  static final String nameTable = "annotation";

  static final AnnotationRepository _annotationRepository =
      AnnotationRepository._internal();

  Database? _db;

  factory AnnotationRepository() {
    return _annotationRepository;
  }

  AnnotationRepository._internal();

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql =
        "CREATE TABLE $nameTable (id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR, description TEXT, date DATETIME)";
    await db.execute(sql);
  }

  initDb() async {
    final databasePath = await getDatabasesPath();
    final localDatabase = join(databasePath, "db_my_annotation.db");

    var db = await openDatabase(localDatabase, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> saveAnnotation(AnnotationModel annotation) async {
    var database = await db;

    int result = await database.insert(nameTable, annotation.toMap());
    return result;
  }

  toRecoverAnnotation() async {
    var database = await db;
    String sql = "SELECT * FROM $nameTable ORDER BY date DESC";

    List annotation = await database.rawQuery(sql);

    return annotation;
  }

  Future<int> updateAnnotation(AnnotationModel annotation) async {
    var database = await db;
    return await database.update(
      nameTable,
      annotation.toMap(),
      where: 'id = ?',
      whereArgs: [annotation.id],
    );
  }

  Future<int> removeAnnotation(int id) async {
    var database = await db;
    return await database.delete(
      nameTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
