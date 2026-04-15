import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class LocalCacheStore {
  Future<File> _fileForKey(String key) async {
    final dir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory(p.join(dir.path, 'offline_cache'));
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return File(p.join(cacheDir.path, '$key.json'));
  }

  Future<void> saveList(String key, List<Map<String, dynamic>> value) async {
    final file = await _fileForKey(key);
    final payload = {
      'updated_at': DateTime.now().toIso8601String(),
      'data': value,
    };
    await file.writeAsString(jsonEncode(payload), flush: true);
  }

  Future<List<Map<String, dynamic>>> readList(String key) async {
    final file = await _fileForKey(key);
    if (!await file.exists()) {
      return const [];
    }

    final content = await file.readAsString();
    if (content.trim().isEmpty) {
      return const [];
    }

    final parsed = jsonDecode(content);
    if (parsed is! Map<String, dynamic>) {
      return const [];
    }

    final rawList = parsed['data'];
    if (rawList is! List) {
      return const [];
    }

    return rawList
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList(growable: false);
  }

  Future<void> saveObject(String key, Map<String, dynamic>? value) async {
    final file = await _fileForKey(key);
    final payload = {
      'updated_at': DateTime.now().toIso8601String(),
      'data': value,
    };
    await file.writeAsString(jsonEncode(payload), flush: true);
  }

  Future<Map<String, dynamic>?> readObject(String key) async {
    final file = await _fileForKey(key);
    if (!await file.exists()) {
      return null;
    }

    final content = await file.readAsString();
    if (content.trim().isEmpty) {
      return null;
    }

    final parsed = jsonDecode(content);
    if (parsed is! Map<String, dynamic>) {
      return null;
    }

    final raw = parsed['data'];
    if (raw is! Map) {
      return null;
    }

    return Map<String, dynamic>.from(raw);
  }
}
