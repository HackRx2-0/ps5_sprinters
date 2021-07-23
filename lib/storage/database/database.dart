import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voice_notification_app/storage/database/data/notification.dart';
import 'package:sqflite/sqflite.dart';

class NotifDatabaseProvider {
  NotifDatabaseProvider._();
  static final NotifDatabaseProvider db = NotifDatabaseProvider._();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "notification.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Notif ("
          "id integer primary key AUTOINCREMENT,"
          "payload TEXT"
          ")");
    });
  }

  addNotifToDatabase(Notif notif) async {
    final db = await database;
    var raw = await db?.insert(
      "Notif",
      notif.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  Future<List<Notif>> getAllNotifs() async {
    final db = await database;
    var response = await db?.query("Notif");
    List<Notif> list = response!.map((c) => Notif.fromMap(c)).toList();
    return list;
  }
}
