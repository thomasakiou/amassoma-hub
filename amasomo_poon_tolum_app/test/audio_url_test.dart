import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:amasomo_poon_tolum/services/learning_api.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Check Audio URLs', () async {
    final file = File('dart_audio_output.txt');
    final sink = file.openWrite();
    const api = LearningApi();
    final vocab = await api.fetchVocabulary();
    for (var v in vocab.take(10)) {
      sink.writeln('Word: ${v.word}');
      sink.writeln('Raw URL: ${v.audioUrl}');
      if (v.audioUrl != null) {
        final uri = api.audioUri(v.audioUrl!);
        sink.writeln('URI: $uri');
        final res = await http.head(uri);
        sink.writeln('HTTP: ${res.statusCode}');
      }
      sink.writeln('---');
    }
    await sink.flush();
    await sink.close();
  });
}
