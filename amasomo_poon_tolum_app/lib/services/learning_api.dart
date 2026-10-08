import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vocab_entry.dart';

const _apiBase = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://vmi2848672.contaboserver.net/amassoma',
);

class LearningApi {
  const LearningApi();

  Future<List<VocabEntry>> fetchVocabulary() async {
    final results = await Future.wait([
      _fetch('/dictionary?skip=0&limit=200', 'words'),
      _fetch('/api/learning/vocabulary?skip=0&limit=200', 'items'),
    ]);
    return results.expand((e) => e).toList(growable: false);
  }

  Future<List<VocabEntry>> _fetch(String path, String key) async {
    final uri = Uri.parse('$_apiBase$path');
    final res = await http.get(uri).timeout(const Duration(seconds: 20));
    if (res.statusCode != 200) return [];
    final payload = jsonDecode(utf8.decode(res.bodyBytes));
    if (payload is! Map || payload[key] is! List) return [];
    return (payload[key] as List)
        .whereType<Map<String, dynamic>>()
        .map(VocabEntry.fromJson)
        .where((e) => e.id.isNotEmpty && e.word.isNotEmpty)
        .toList(growable: false);
  }

  Uri audioUri(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Uri.parse(path);
    }
    final base = Uri.parse(_apiBase);
    final basePath = base.path.replaceFirst(RegExp(r'/$'), '');
    final assetPath = path.startsWith('/') ? path : '/$path';
    if (basePath.isNotEmpty && !assetPath.startsWith('$basePath/')) {
      return base.resolve('$basePath$assetPath');
    }
    return base.resolve(assetPath);
  }
}
