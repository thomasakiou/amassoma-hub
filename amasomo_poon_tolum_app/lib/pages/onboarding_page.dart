import 'package:flutter/material.dart';
import '../models/learner_profile.dart';
import '../theme.dart';
import '../widgets/tactile_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, required this.onComplete});
  final void Function(LearnerProfile) onComplete;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final TextEditingController _nameController = TextEditingController();
  String _goal = 'family';
  String _cadence = 'Steady';

  static const _goals = [
    (
      id: 'family',
      icon: Icons.family_restroom,
      title: 'Connect with Family & Heritage',
      sub: 'Elders, grandparents, village roots in Bayelsa',
    ),
    (
      id: 'travel',
      icon: Icons.festival,
      title: 'Travel & Cultural Festivals',
      sub: 'Ogori, Canoe Regatta, Seigbein celebrations',
    ),
    (
      id: 'academic',
      icon: Icons.menu_book,
      title: 'Academic & Linguistic Pride',
      sub: 'Preserving Niger Delta coastal dialects',
    ),
    (
      id: 'fun',
      icon: Icons.psychology,
      title: 'Brain Exercise & Fun',
      sub: 'Quick bite-sized daily puzzle games',
    ),
  ];

  static const _cadences = [
    ('Casual', '5 min / day'),
    ('Steady', '10 min / day'),
    ('Serious', '15 min / day'),
    ('Intense', '20 min / day'),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            _mascotBubble(),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'What is your name? / Imini duko?',
                labelStyle: TextStyle(color: onSurfaceVariant),
                filled: true,
                fillColor: surfaceContainerLowest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Pick your primary motivation',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: onSurfaceVariant,
                    letterSpacing: 0.5)),
            const SizedBox(height: 10),
            ..._goals.map(_goalCard),
            const SizedBox(height: 24),
            Row(children: [
              Text('Daily Target Pace',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: onSurfaceVariant,
                      letterSpacing: 0.5)),
              const Spacer(),
              Icon(Icons.bolt, size: 16, color: primary),
              Text(' Flexible',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: primary)),
            ]),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.4,
              children: _cadences.map(_cadencePill).toList(),
            ),
            const SizedBox(height: 32),
            TactileButton(
              label: 'Continue / Pọọn',
              icon: Icons.arrow_forward,
              onTap: () {
                final name = _nameController.text.trim();
                final profile = LearnerProfile(
                  name: name.isEmpty ? 'Learner' : name,
                  goal: _goal,
                  cadence: _cadence,
                );
                widget.onComplete(profile);
              },
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {},
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14),
                    children: [
                      TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(color: outline)),
                      TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                              color: primary, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mascotBubble() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: surfaceContainer,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.flutter_dash, size: 36, color: primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text('Tolu the Kingfisher',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: primary,
                          letterSpacing: 0.5)),
                  const SizedBox(width: 6),
                  Text('Bayelsa Guide',
                      style: TextStyle(fontSize: 11, color: outline)),
                ]),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: onSurface),
                    children: [
                      TextSpan(
                          text: 'Ebieye! ',
                          style: TextStyle(
                              color: primary, fontWeight: FontWeight.w800)),
                      const TextSpan(
                          text: 'Why do you want to learn Amassoma (Izon)?'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _goalCard(
      ({String id, IconData icon, String title, String sub}) goal) {
    final selected = _goal == goal.id;
    return GestureDetector(
      onTap: () => setState(() => _goal = goal.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? primary.withOpacity(0.08) : surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: selected ? primary : surfaceContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(goal.icon,
                  color: selected ? onPrimary : onSurface, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(goal.title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800)),
                  Text(goal.sub,
                      style: TextStyle(fontSize: 12, color: onSurfaceVariant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: selected ? primary : surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: selected
                  ? const Icon(Icons.check, color: onPrimary, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cadencePill((String label, String sub) cadence) {
    final selected = _cadence == cadence.$1;
    return GestureDetector(
      onTap: () => setState(() => _cadence = cadence.$1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? primary.withOpacity(0.1) : surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(cadence.$1,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: selected ? primary : onSurface)),
            Text(cadence.$2,
                style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
