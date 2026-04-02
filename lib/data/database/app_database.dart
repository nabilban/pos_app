import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import '../entity/token_entity.dart';
import '../entity/user_entity.dart';
import '../entity/role_entity.dart';
import '../entity/outlet_entity.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Tokens, Users, Roles, Outlets])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 5) {
            await m.issueCustomQuery('DROP TABLE IF EXISTS tokens');
            await m.issueCustomQuery('DROP TABLE IF EXISTS users');
            await m.issueCustomQuery('DROP TABLE IF EXISTS roles');
            await m.issueCustomQuery('DROP TABLE IF EXISTS outlets');
            await m.createAll();
          }
        },
      );

  // --- TOKEN OPERATIONS ---

  Future<String?> getActiveToken() async {
    final t = await (select(tokens)..limit(1)).getSingleOrNull();
    return t?.token;
  }

  Future<void> saveToken(String newToken) async {
    transaction(() async {
      await delete(tokens).go();
      await into(tokens).insert(TokensCompanion.insert(token: newToken));
    });
  }

  Future<void> clearToken() async {
    await delete(tokens).go();
  }

  // --- USER OPERATIONS ---

  Future<void> saveUserContext({
    required UsersCompanion user,
    required RolesCompanion role,
    OutletsCompanion? outlet,
  }) async {
    transaction(() async {
      await delete(users).go();
      await delete(roles).go();
      await delete(outlets).go();

      await into(users).insert(user);
      await into(roles).insert(role);
      if (outlet != null) {
        await into(outlets).insert(outlet);
      }
    });
  }

  Future<User?> getActiveUser() async {
    return await (select(users)..limit(1)).getSingleOrNull();
  }

  Future<Role?> getActiveRole() async {
    return await (select(roles)..limit(1)).getSingleOrNull();
  }

  Future<Outlet?> getActiveOutlet() async {
    return await (select(outlets)..limit(1)).getSingleOrNull();
  }

  Future<void> clearUserContext() async {
    transaction(() async {
      await delete(users).go();
      await delete(roles).go();
      await delete(outlets).go();
    });
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
