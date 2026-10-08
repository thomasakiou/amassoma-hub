import 'package:flutter/material.dart';
import '../models/learner_profile.dart';
import '../models/vocab_entry.dart';
import '../services/learning_api.dart';
import '../theme.dart';
import '../widgets/tactile_button.dart';

class PlacementTestPage extends StatefulWidget {
  const PlacementTestPage({
    super.key,
    required this.profile,
    required this.onComplete,
  });
  final LearnerProfile profile;
  final void Function(LearnerProfile) onComplete;

  @override
  State<PlacementTestPage> createState() => _PlacementTestPageState();
}

class _PlacementTestPageState extends State<PlacementTestPage> {
  static const _questions = [
    (
      prompt: 'What does "Ebimi nua" mean?',
      options: ['Good morning, friend!', 'Good evening, mother!', 'Safe travels!', 'Come and eat!'],
      correct: 0,
      izon: 'Ebimi nua, wẹnị bọ!',
      phonetic: '/Eh-bee-mee noo-ah/',
    ),
    (
      prompt: 'Choose the respectful greeting for an elder:',
      options: ['Aan, Doo!', 'Wẹnị bọ', 'Beni pụ́', 'Fiyai fị'],
      correct: 0,
      izon: 'Dooo, Dau!',
      phonetic: '/dōː dàʊ/',
    ),
    (
      prompt: 'What does "Beni" mean?',
      options: ['Water / River', 'Food / Meal', 'Uncle / Elder', 'Walk / Travel'],
      correct: 0,
      izon: 'Beni',
      phonetic: '/beh-nee/',
    ),
    (
      prompt: 'How do you say "Well done / Bravo"?',
      options: ['Tọrọ nua', 'Doo', 'Fiyai', 'Kọkọ'],
      correct: 0,
      izon: 'Tọrọ nua!',
      phonetic: '/toh-roh noo-ah/',
    ),
    (
      prompt: 'What does "Fiyai" mean?',
      options: ['Food / Prepared meal', 'Water / River', 'Peace / Prosperity', 'Walk / Travel'],
      correct: 0,
      izon: 'Fiyai',
      phonetic: '/fee-yah-ee/',
    ),
  ];

  int _current = 0;
  int? _selected;
  bool _checked = false;
  int _score = 0;

  void _check() {
    if (_selected == null) return;
    setState(() {
      _checked = true;
      if (_selected == _questions[_current].correct) _score++;
    });
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() {
        _current++;
        _selected = null;
        _checked = false;
      });
    } else {
      final profile = widget.profile
        ..xp += _score * 15
        ..cowries += _score * 10
        ..placementDone = true
        ..level = _score >= 4 ? 'Explorer' : _score >= 2 ? 'Beginner' : 'Starter';
      widget.onComplete(profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_current];
    final progress = (_current + 1) / _questions.length;

    return Scaffold(
      backgroundColor: surface,
      appBar: AppBar(
        backgroundColor: surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Row(children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: surfaceContainerHigh,
                color: primary,
                minHeight: 10,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: surfaceContainerHigh,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text('${_current + 1} of ${_questions.length}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: tertiaryFixed,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.hearing, size: 16, color: onTertiaryFixed),
                    const SizedBox(width: 4),
                    Text('PLACEMENT TEST',
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: onTertiaryFixed,
                            letterSpacing: 0.5)),
                  ]),
                ),
                const SizedBox(height: 12),
                Text(q.prompt,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3)),
                const SizedBox(height: 16),
                _audioCard(q.izon, q.phonetic),
                const SizedBox(height: 16),
                ...List.generate(q.options.length, (i) => _optionCard(i, q)),
                const SizedBox(height: 16),
                _culturalNote(),
              ],
            ),
          ),
          _bottomDock(q),
        ],
      ),
    );
  }

  Widget _audioCard(String izon, String phonetic) {
    return Container(
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
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: tertiary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFF004B73),
                      offset: Offset(0, 5),
                      blurRadius: 0)
                ],
              ),
              child: const Icon(Icons.volume_up, color: onTertiary, size: 30),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('"$izon"',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800)),
              Text(phonetic,
                  style: TextStyle(fontSize: 12, color: tertiary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _optionCard(int index, dynamic q) {
    final labels = ['A', 'B', 'C', 'D'];
    final isSelected = _selected == index;
    final isCorrect = _checked && index == q.correct;
    final isWrong = _checked && isSelected && index != q.correct;

    Color bg = surfaceContainerLowest;
    Color borderColor = outlineVariant;
    if (isCorrect) {
      bg = const Color(0xFFF0FDF4);
      borderColor = primary;
    } else if (isWrong) {
      bg = const Color(0xFFFFF7ED);
      borderColor = errorColor;
    } else if (isSelected) {
      bg = surfaceContainerLow;
      borderColor = primary;
    }

    return GestureDetector(
      onTap: _checked ? null : () => setState(() => _selected = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
                color: isSelected ? primary.withOpacity(0.15) : Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected || isCorrect ? primary : surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isSelected || isCorrect
                    ? const Icon(Icons.check, color: onPrimary, size: 16)
                    : Text(labels[index],
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(q.options[index],
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isCorrect ? primary : onSurface)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _culturalNote() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: secondaryFixed.withOpacity(0.5),
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
            child: const Icon(Icons.lightbulb, size: 18, color: onSecondaryContainer),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Bayelsa Waterway Etiquette',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'In Amassoma traditions, welcoming an elder arriving by canoe requires adding "Dau" (Father) or "Yin" (Mother) after "Doo" before any conversation.',
                  style: TextStyle(fontSize: 13, color: onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomDock(dynamic q) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      color: surface,
      child: Column(
        children: [
          if (!_checked)
            TactileButton(
              label: 'Check Answer',
              icon: Icons.arrow_forward,
              onTap: _selected != null ? _check : () {},
              color: _selected != null ? primary : surfaceContainerHigh,
              shadowColor: _selected != null
                  ? const Color(0xFF005320)
                  : outlineVariant,
              textColor: _selected != null ? onPrimary : onSurfaceVariant,
            )
          else
            TactileButton(
              label: _current < _questions.length - 1
                  ? 'Next Question'
                  : 'See Results',
              icon: Icons.arrow_forward,
              onTap: _next,
            ),
          if (!_checked) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: _next,
              child: Text("I don't know this yet — skip for now",
                  style: TextStyle(color: outline, fontSize: 13)),
            ),
          ],
        ],
      ),
    );
  }
}
