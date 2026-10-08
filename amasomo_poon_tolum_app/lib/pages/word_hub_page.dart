import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../models/vocab_entry.dart';
import '../services/learning_api.dart';
import '../theme.dart';

class WordHubPage extends StatefulWidget {
  const WordHubPage({super.key, required this.vocab});
  final List<VocabEntry> vocab;

  @override
  State<WordHubPage> createState() => _WordHubPageState();
}

class _WordHubPageState extends State<WordHubPage> {
  static const _api = LearningApi();
  final _player = AudioPlayer();
  final _searchCtrl = TextEditingController();
  String _category = 'All';
  bool _cardFlipped = false;
  final Set<String> _bookmarked = {};

  List<VocabEntry> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    return widget.vocab.where((e) {
      final matchQ = q.isEmpty ||
          e.word.toLowerCase().contains(q) ||
          e.translation.toLowerCase().contains(q);
      final matchCat = _category == 'All' || e.category == _category;
      return matchQ && matchCat;
    }).toList();
  }

  List<String> get _categories {
    final cats = {'All', ...widget.vocab.map((e) => e.category)};
    return cats.toList();
  }

  Future<void> _play(VocabEntry e) async {
    if (e.audioUrl == null) {
      _showMissingAudioMsg();
      return;
    }
    try {
      await _player.stop();
      await _player.play(UrlSource(_api.audioUri(e.audioUrl!).toString()));
    } catch (_) {
      _showMissingAudioMsg();
    }
  }

  void _showMissingAudioMsg() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            const Text('Audio clip is currently unavailable on the server.'),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final featured = widget.vocab.isNotEmpty ? widget.vocab.first : null;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      children: [
        _searchBar(),
        const SizedBox(height: 8),
        _categoryPills(),
        const SizedBox(height: 16),
        if (featured != null) _wordOfDayCard(featured),
        const SizedBox(height: 16),
        if (featured != null) _flashcardSection(featured),
        const SizedBox(height: 16),
        _unlockedWords(filtered),
        const SizedBox(height: 16),
        _audioDrillBanner(),
      ],
    );
  }

  Widget _searchBar() {
    return Row(children: [
      Expanded(
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _searchCtrl,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search words in Amassoma or English...',
              hintStyle: TextStyle(fontSize: 14, color: onSurfaceVariant),
              prefixIcon: const Icon(Icons.search, color: onSurfaceVariant),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.mic, color: tertiary, size: 22),
      ),
    ]);
  }

  Widget _categoryPills() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final cat = _categories[i];
          final sel = _category == cat;
          return GestureDetector(
            onTap: () => setState(() => _category = cat),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: sel ? primary : surfaceContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Center(
                child: Text(cat,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: sel ? onPrimary : onSurfaceVariant)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _wordOfDayCard(VocabEntry e) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [secondaryContainer, secondaryFixed, primaryFixed]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _pill('✨ Word of the Day', secondaryFixed.withOpacity(0.4),
                secondary),
            _pill('Central Izon', tertiaryFixed.withOpacity(0.4), tertiary),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.word,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: primary)),
                    if (e.pronunciation != null)
                      Text('/${e.pronunciation}/',
                          style: TextStyle(
                              fontSize: 13,
                              color: onSurfaceVariant,
                              fontStyle: FontStyle.italic)),
                    const SizedBox(height: 4),
                    Text(e.translation,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                  ]),
            ),
            GestureDetector(
              onTap: () => _play(e),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: tertiary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Color(0xFF004B73), offset: Offset(0, 4))
                  ],
                ),
                child: const Icon(Icons.volume_up, color: onTertiary, size: 26),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: surfaceContainerLow,
                borderRadius: BorderRadius.circular(10)),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.auto_stories, color: secondary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Invoked by Amassoma elders during annual new yam festivals and canoe flotillas to usher tranquility over the river ways.',
                  style: TextStyle(fontSize: 12, color: onSurfaceVariant),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _pill(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(label,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w700, color: textColor)),
    );
  }

  Widget _flashcardSection(VocabEntry e) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Icon(Icons.style, color: primary, size: 20),
        const SizedBox(width: 6),
        const Text('Interactive Flashcard',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const Spacer(),
        Text('Tap to inspect',
            style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
      ]),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: () => setState(() => _cardFlipped = !_cardFlipped),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 350),
          crossFadeState: _cardFlipped
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: _cardFront(e),
          secondChild: _cardBack(e),
        ),
      ),
    ]);
  }

  Widget _cardFront(VocabEntry e) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _pill('Category: ${e.category}', primaryFixed.withOpacity(0.4),
              onPrimaryFixedVariant),
          Row(children: [
            const Icon(Icons.touch_app, size: 16, color: onSurfaceVariant),
            const SizedBox(width: 3),
            Text('Flip',
                style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
          ]),
        ]),
        const Spacer(),
        Row(children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
                color: surfaceContainerHigh,
                borderRadius: BorderRadius.circular(16)),
            child:
                const Center(child: Text('🙏', style: TextStyle(fontSize: 28))),
          ),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(e.word,
                style: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w800, color: primary)),
            Text(e.translation,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          ]),
        ]),
        const Spacer(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Essential Riverine Etiquette',
              style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
          Text('Tap for example →',
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700, color: secondary)),
        ]),
      ]),
    );
  }

  Widget _cardBack(VocabEntry e) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _pill('Context & Usage', surfaceContainerLow, primary),
          Row(children: [
            const Icon(Icons.replay, size: 16, color: onSurfaceVariant),
            const SizedBox(width: 3),
            Text('Tap to return',
                style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
          ]),
        ]),
        const SizedBox(height: 10),
        Text('Example Dialogue',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: tertiary,
                letterSpacing: 0.5)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: surfaceContainerLowest,
              borderRadius: BorderRadius.circular(10)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('"${e.word}, Tari!"',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700, color: primary)),
            Text('"Greetings, Tari! (${e.translation})"',
                style: TextStyle(fontSize: 14, color: onSurfaceVariant)),
          ]),
        ),
        const Spacer(),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          const Icon(Icons.check_circle, size: 16, color: primary),
          const SizedBox(width: 4),
          const Text('High frequency word',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700, color: primary)),
        ]),
      ]),
    );
  }

  Widget _unlockedWords(List<VocabEntry> entries) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Icon(Icons.collections_bookmark, color: secondary, size: 20),
        const SizedBox(width: 6),
        const Text('Unlocked Words',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: surfaceContainer,
              borderRadius: BorderRadius.circular(999)),
          child: Text('${entries.length} ready',
              style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
        ),
      ]),
      const SizedBox(height: 10),
      ...entries.take(10).map(_wordCard),
    ]);
  }

  Widget _wordCard(VocabEntry e) {
    final bookmarked = _bookmarked.contains(e.id);
    final stars = e.word.length % 3 + 1;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(children: [
        GestureDetector(
          onTap: () => _play(e),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: tertiaryFixed,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: tertiaryFixedDim, offset: Offset(0, 3))
              ],
            ),
            child:
                const Icon(Icons.volume_up, color: onTertiaryFixed, size: 22),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(e.word,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: primaryFixed.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  stars == 3
                      ? 'Mastered'
                      : stars == 2
                          ? 'Practicing'
                          : 'Learning',
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: onPrimaryFixedVariant),
                ),
              ),
            ]),
            Text(e.translation,
                style: TextStyle(fontSize: 13, color: onSurfaceVariant)),
            Row(
              children: List.generate(
                  3,
                  (i) => Icon(
                        i < stars ? Icons.star : Icons.star_border,
                        size: 15,
                        color: i < stars ? secondaryContainer : outlineVariant,
                      )),
            ),
          ]),
        ),
        IconButton(
          onPressed: () => setState(() {
            bookmarked ? _bookmarked.remove(e.id) : _bookmarked.add(e.id);
          }),
          icon: Icon(
            bookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: bookmarked ? primary : outlineVariant,
          ),
        ),
      ]),
    );
  }

  Widget _audioDrillBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: surfaceContainerHigh, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        Row(children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: secondaryContainer,
                borderRadius: BorderRadius.circular(12)),
            child:
                const Center(child: Text('🎧', style: TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Quick 2-Minute Audio Drill',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
              Text('Sharpen ear tones & dialect accuracy',
                  style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: secondaryFixed,
                borderRadius: BorderRadius.circular(999)),
            child: const Text('+25 XP',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: onSecondaryFixed)),
          ),
        ]),
        const SizedBox(height: 10),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color(0xFF005320), offset: Offset(0, 4))
            ],
          ),
          child:
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.hearing, color: onPrimary, size: 20),
            SizedBox(width: 8),
            Text('Start Listening Drill',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: onPrimary)),
          ]),
        ),
      ]),
    );
  }
}
