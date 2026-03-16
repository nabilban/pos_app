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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(tokens, tokens.userName);
            await m.addColumn(tokens, tokens.roleName);
            await m.addColumn(tokens, tokens.outletName);
          }
        },
      );

  // Retrieve auth data including token and user info
  Future<Map<String, String?>> getAuthData() async {
    final t = await (select(tokens)..limit(1)).getSingleOrNull();
    return {
      'token': t?.token,
      'userName': t?.userName,
      'roleName': t?.roleName,
      'outletName': t?.outletName,
    };
  }

  // Retrieve the single active token (legacy support if needed)
  Future<String?> getActiveToken() async {
    final data = await getAuthData();
    return data['token'];
  }

  // Save auth data (clearing any existing tokens first)
  Future<void> saveAuthData({
    required String token,
    String? userName,
    String? roleName,
    String? outletName,
  }) async {
    transaction(() async {
      await delete(tokens).go();
      await into(tokens).insert(TokensCompanion.insert(
        token: token,
        userName: Value(userName),
        roleName: Value(roleName),
        outletName: Value(outletName),
      ));
    });
  }

  // Save a token (legacy support)
  Future<void> saveToken(String newToken) async {
    await saveAuthData(token: newToken);
  }

  // Delete all auth data
  Future<void> clearAuthData() async {
    await delete(tokens).go();
  }

  // Delete token (legacy support)
  Future<void> clearToken() async {
    await clearAuthData();
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
