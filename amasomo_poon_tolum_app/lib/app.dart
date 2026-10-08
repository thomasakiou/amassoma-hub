import 'package:flutter/material.dart';
import 'models/learner_profile.dart';
import 'models/vocab_entry.dart';
import 'pages/learning_path_page.dart';
import 'pages/lesson_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/placement_results_page.dart';
import 'pages/placement_test_page.dart';
import 'pages/profile_page.dart';
import 'pages/word_hub_page.dart';
import 'services/learning_api.dart';
import 'theme.dart';
import 'widgets/stat_bar.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static const _api = LearningApi();

  LearnerProfile _profile = LearnerProfile(name: 'Learner');
  List<VocabEntry> _vocab = [];
  bool _loading = true;

  // flow: onboarding → placement → results → main
  bool _onboarded = false;
  bool _placementDone = false;
  bool _showResults = false;

  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _loadVocab();
  }

  Future<void> _loadVocab() async {
    try {
      final entries = await _api.fetchVocabulary();
      if (mounted) setState(() { _vocab = entries; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _completeOnboarding(LearnerProfile p) =>
      setState(() { _profile = p; _onboarded = true; });

  void _completePlacement(LearnerProfile p) =>
      setState(() { _profile = p; _placementDone = true; _showResults = true; });

  void _startLearning() =>
      setState(() { _showResults = false; });

  @override
  Widget build(BuildContext context) {
    if (!_onboarded) {
      return OnboardingPage(onComplete: _completeOnboarding);
    }
    if (!_placementDone) {
      return PlacementTestPage(profile: _profile, onComplete: _completePlacement);
    }
    if (_showResults) {
      return PlacementResultsPage(profile: _profile, onStart: _startLearning);
    }
    return _mainShell();
  }

  Widget _mainShell() {
    final pages = [
      LearningPathPage(
        profile: _profile,
        onStartLesson: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => LessonPage(
              profile: _profile,
              vocab: _vocab,
              onComplete: (p) {
                setState(() => _profile = p);
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      WordHubPage(vocab: _vocab),
      ProfilePage(profile: _profile),
    ];

    return Scaffold(
      backgroundColor: surface,
      appBar: AppBar(
        backgroundColor: surface,
        elevation: 0,
        titleSpacing: 20,
        title: Row(children: [
          const Icon(Icons.flutter_dash, color: primary, size: 28),
          const SizedBox(width: 8),
          Text('Amasomo',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: primary)),
        ]),
        actions: [
          if (!_loading) StatBar(profile: _profile),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 16,
            backgroundColor: primary,
            child: const Icon(Icons.person, color: onPrimary, size: 18),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        top: false,
        child: _loading
            ? const Center(child: CircularProgressIndicator(color: primary))
            : IndexedStack(index: _tab, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        backgroundColor: surface,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Path',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Word Hub',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
