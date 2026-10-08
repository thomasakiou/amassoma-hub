class VocabEntry {
  const VocabEntry({
    required this.id,
    required this.word,
    required this.translation,
    required this.category,
    this.pronunciation,
    this.audioUrl,
  });

  final String id;
  final String word;
  final String translation;
  final String category;
  final String? pronunciation;
  final String? audioUrl;

  factory VocabEntry.fromJson(Map<String, dynamic> json) {
    final fromDictionary =
        json.containsKey('english_word') || json.containsKey('izon_word');
    final rawPron = json['phonetic'] ?? json['pronunciation'];
    final pron = rawPron
        ?.toString()
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll('&nbsp;', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .split(RegExp(r'\b(?:Explanation|Breakdown):', caseSensitive: false))
        .first
        .trim();
    return VocabEntry(
      id: json['id']?.toString() ?? '',
      word: (fromDictionary ? json['izon_word'] : json['word'])?.toString() ?? '',
      translation:
          (fromDictionary ? json['english_word'] : json['translation'])
                  ?.toString() ??
              '',
      category: fromDictionary
          ? 'Dictionary'
          : json['category']?.toString() ?? 'Word',
      pronunciation: (pron?.isEmpty ?? true) ? null : pron,
      audioUrl: json['audio_url']?.toString(),
    );
  }
}
