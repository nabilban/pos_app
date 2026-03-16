import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import '../entity/token_entity.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Tokens])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Retrieve the single active token (we assume there's only one)
  Future<String?> getActiveToken() async {
    final t = await (select(tokens)..limit(1)).getSingleOrNull();
    return t?.token;
  }

  // Save a token (clearing any existing tokens first)
  Future<void> saveToken(String newToken) async {
    transaction(() async {
      await delete(tokens).go();
      await into(tokens).insert(TokensCompanion.insert(token: newToken));
    });
  }

  // Delete token
  Future<void> clearToken() async {
    await delete(tokens).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // // Work around limitations on old Android versions
    // if (Platform.isAndroid) {
    //   await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    // }

    // Make sqlite3 pick up the native library and cache directory properly
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
