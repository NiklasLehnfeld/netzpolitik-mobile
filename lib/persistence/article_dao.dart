import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/persistence/wp_database.dart';
import 'package:sqflite/sqflite.dart';

abstract class ArticleDAOListener {
  void onContentChanged();
} 

class ArticleDAO {

  final WPDatabase database;
  final Set<ArticleDAOListener> _listeners = {};

  ArticleDAO(this.database);

  void listen(ArticleDAOListener listener) => _listeners.add(listener);

  void unlisten(ArticleDAOListener listener) => _listeners.remove(listener);

  Future<void> insert(Article article) async {

    final db = await database.open();

    await db.insert(
      'articles',
      article.toDatabaseMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
    _notifyOnChange();
  }

  Future<List<Article>> getAll() async {
    final db = await database.open();

    final maps = await db.query('articles');

    return maps.map((e) => Article.fromDatabase(e)).toList();
  }

  Future<void> delete(int id) async {
    final db = await database.open();

    await db.delete(
      'articles',
      where: 'id = ?',
      whereArgs: [id],
    );

    _notifyOnChange();
  }

  Future<Article> getById(int id) async {
    final db = await database.open();

    final map = await db.query(
      'articles',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (map.isEmpty) {
      return null;
    }

    return Article.fromDatabase(map.first);
  }

  Future<bool> isStored(Article article) async {
    final result = await getById(article.id);

    return result != null;
  }
  
  void _notifyOnChange() => _listeners.forEach((listener) => listener.onContentChanged());



}