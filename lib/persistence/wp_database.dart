import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WPDatabase {

  Future<Database> open() async => openDatabase(
        join(await getDatabasesPath(), 'wp_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE articles('
                'id INTEGER PRIMARY KEY,'
                'title TEXT, '
                'subTitle TEXT, '
                'categories TEXT, '
                'tags TEXT, '
                'authors TEXT, '
                'replies TEXT, '
                'content TEXT, '
                'summary TEXT, '
                'date TEXT, '
                'modified TEXT, '
                'imageName TEXT, '
                'link TEXT, '
                'imageCaption TEXT, '
             ')',
          );
        },
        onUpgrade: (db, oldVersion, newVersion) {
          if (oldVersion < 2) {
            db.execute('ALTER TABLE articles ADD COLUMN link TEXT');
            db.execute('ALTER TABLE articles ADD COLUMN imageCaption');
            db.execute('ALTER TABLE articles ADD COLUMN imageLicenceCaption');
          }
        },
        version: 2,
      );
}
