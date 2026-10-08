import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../models/learner_profile.dart';
import '../models/vocab_entry.dart';
import '../services/learning_api.dart';
import '../theme.dart';
import '../widgets/tactile_button.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({
    super.key,
    required this.profile,
    required this.vocab,
    required this.onComplete,
  });
  final LearnerProfile profile;
  final List<VocabEntry> vocab;
  final void Function(LearnerProfile) onComplete;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  static const _api = LearningApi();
  final _player = AudioPlayer();

  int _questionIndex = 0;
  int? _selected;
  bool _checked = false;
  bool _correct = false;
  int _score = 0;

  List<_Question> _questions = [];

  @override
  void initState() {
    super.initState();
    _buildQuestions();
  }

  void _buildQuestions() {
    final entries = widget.vocab.take(8).toList();
    if (entries.isEmpty) return;
    _questions = entries.map((e) {
      final distractors = widget.vocab
          .where((v) => v.id != e.id)
          .take(3)
          .map((v) => v.translation)
          .toList();
      final options = [e.translation, ...distractors]..shuffle();
      return _Question(
        entry: e,
        options: options,
        correctIndex: options.indexOf(e.translation),
      );
    }).toList();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playAudio(VocabEntry entry) async {
    if (entry.audioUrl == null) {
      _showMissingAudioMsg();
      return;
    }
    try {
      await _player.stop();
      await _player.play(UrlSource(_api.audioUri(entry.audioUrl!).toString()));
    } catch (_) {
      _showMissingAudioMsg();
    }
  }

  void _showMissingAudioMsg() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Audio clip is currently unavailable on the server.'),
        backgroundColor: errorColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _check() {
    if (_selected == null) return;
    final q = _questions[_questionIndex];
    final isCorrect = _selected == q.correctIndex;
    setState(() {
      _checked = true;
      _correct = isCorrect;
      if (isCorrect) _score++;
    });
  }

  void _next() {
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
        _selected = null;
        _checked = false;
        _correct = false;
      });
    } else {
      final profile = widget.profile
        ..xp += _score * 15
        ..cowries += _score * 5
        ..currentLesson = (widget.profile.currentLesson + 1).clamp(1, 50);
      widget.onComplete(profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: surface,
        appBar: AppBar(
          backgroundColor: surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(child: CircularProgressIndicator(color: primary)),
      );
    }

    final q = _questions[_questionIndex];
    final progress = (_questionIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: surface,
      appBar: AppBar(
        backgroundColor: surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Active Exercise',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: primary,
              child: const Icon(Icons.person, color: onPrimary, size: 18),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: surfaceContainerHigh,
                      color: primary,
                      minHeight: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: errorContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.favorite, size: 16, color: errorColor),
                    const SizedBox(width: 3),
                    Text('${widget.profile.hearts}',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
                  ]),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: tertiaryFixed,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.diamond, size: 16, color: tertiary),
                    const SizedBox(width: 3),
                    Text('+${_score * 15} XP',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: onTertiaryFixed)),
                  ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                _mascotPromptCard(q.entry),
                const SizedBox(height: 16),
                ...List.generate(q.options.length, (i) => _optionCard(i, q)),
                const SizedBox(height: 16),
                _wordBankChips(q.entry),
                const SizedBox(height: 12),
                _culturalNote(q.entry),
              ],
            ),
          ),
          _bottomTray(q),
        ],
      ),
    );
  }

  Widget _mascotPromptCard(VocabEntry entry) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.flutter_dash, size: 36, color: primary),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.record_voice_over,
                    size: 13, color: onSecondaryContainer),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: secondaryFixed,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text('🌿 NEW PHRASE',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: onSecondaryFixed)),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.speed, size: 14),
                      label: const Text('Slow', style: TextStyle(fontSize: 12)),
                      style: TextButton.styleFrom(
                          foregroundColor: onSurfaceVariant,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _playAudio(entry),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: tertiary,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xFF004B73),
                                  offset: Offset(0, 4),
                                  blurRadius: 0)
                            ],
                          ),
                          child: const Icon(Icons.volume_up,
                              color: onTertiary, size: 26),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.word,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            if (entry.pronunciation != null)
                              Text('[${entry.pronunciation}]',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: onSurfaceVariant,
                                      fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text('Select the correct English translation:',
                    style: TextStyle(fontSize: 13, color: onSurfaceVariant)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionCard(int index, _Question q) {
    final labels = ['A', 'B', 'C', 'D'];
    final isSelected = _selected == index;
    final isCorrect = _checked && index == q.correctIndex;
    final isWrong = _checked && isSelected && !_correct;

    Color bg = surfaceContainerLowest;
    if (isCorrect) bg = const Color(0xFFF0FDF4);
    if (isWrong) bg = const Color(0xFFFFF7ED);
    if (isSelected && !_checked) bg = primaryFixedDim.withOpacity(0.1);

    return GestureDetector(
      onTap: _checked ? null : () => setState(() => _selected = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected || isCorrect ? primary : surfaceContainerHigh,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: isSelected || isCorrect
                    ? const Icon(Icons.check, color: onPrimary, size: 18)
                    : Text(labels[index],
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(q.options[index],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isCorrect ? primary : onSurface)),
                  if (isCorrect)
                    Row(children: [
                      const Icon(Icons.auto_awesome, size: 13, color: primary),
                      const SizedBox(width: 3),
                      Text('Correct!',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primary)),
                    ]),
                ],
              ),
            ),
            if (isSelected || isCorrect)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isCorrect ? primary : (isWrong ? errorColor : primary),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: onPrimary, size: 16),
              ),
          ],
        ),
      ),
    );
  }

  Widget _wordBankChips(VocabEntry entry) {
    final parts = entry.word.split(' ');
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.lightbulb, size: 16, color: primary),
            const SizedBox(width: 4),
            Text('Root Vocabulary Explorer',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: onSurfaceVariant,
                    letterSpacing: 0.5)),
            const Spacer(),
            Text('Tap word to listen',
                style: TextStyle(fontSize: 11, color: onSurfaceVariant)),
          ]),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: parts
                .map((p) => GestureDetector(
                      onTap: () => _playAudio(entry),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 3,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(p,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: primary)),
                          const SizedBox(width: 4),
                          const Icon(Icons.volume_up,
                              size: 13, color: tertiary),
                        ]),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _culturalNote(VocabEntry entry) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceContainerHighest.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: secondaryContainer,
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.school, size: 18, color: onSecondaryContainer),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dialect Note: Amassoma (Central Izon)',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: secondary,
                        letterSpacing: 0.3)),
                const SizedBox(height: 3),
                Text(
                  '"${entry.word}" — ${entry.translation}. Category: ${entry.category}.',
                  style: TextStyle(fontSize: 13, color: onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomTray(_Question q) {
    if (!_checked) {
      return Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        color: surface,
        child: TactileButton(
          label: 'Check Answer',
          icon: Icons.arrow_forward,
          onTap: _selected != null ? _check : () {},
          color: _selected != null ? primary : surfaceContainerHigh,
          shadowColor:
              _selected != null ? const Color(0xFF005320) : outlineVariant,
          textColor: _selected != null ? onPrimary : onSurfaceVariant,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _correct ? primary : errorColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, -4))
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: surfaceContainerLowest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _correct ? Icons.verified : Icons.close,
                    color: _correct ? primary : errorColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _correct ? 'Amazing! (Tọrọ nua!)' : 'Not quite!',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: onPrimary),
                      ),
                      Text(
                        _correct
                            ? 'You caught the nuanced greeting!'
                            : 'Correct: ${q.options[q.correctIndex]}',
                        style: TextStyle(
                            fontSize: 13, color: onPrimary.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ),
                if (_correct)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: secondaryContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.local_fire_department,
                          size: 13, color: onSecondaryContainer),
                      const SizedBox(width: 2),
                      const Text('+1',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: onSecondaryContainer)),
                    ]),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () => _playAudio(q.entry),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: onPrimary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.replay, color: onPrimary, size: 22),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: _next,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('PỌỌN / CONTINUE',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: _correct ? primary : errorColor)),
                          const SizedBox(width: 6),
                          Icon(Icons.arrow_forward,
                              size: 20, color: _correct ? primary : errorColor),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Question {
  const _Question({
    required this.entry,
    required this.options,
    required this.correctIndex,
  });
  final VocabEntry entry;
  final List<String> options;
  final int correctIndex;
}
