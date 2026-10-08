import 'package:flutter/material.dart';
import '../models/learner_profile.dart';
import '../theme.dart';
import '../widgets/tactile_button.dart';

class PlacementResultsPage extends StatelessWidget {
  const PlacementResultsPage({
    super.key,
    required this.profile,
    required this.onStart,
  });
  final LearnerProfile profile;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            _celebrationHeader(),
            const SizedBox(height: 16),
            _rewardRibbon(),
            const SizedBox(height: 12),
            _diagnosticCard(),
            const SizedBox(height: 16),
            _learningPath(),
            const SizedBox(height: 24),
            TactileButton(
              label: 'Start From Unit 2 (Recommended)',
              icon: Icons.play_circle,
              onTap: onStart,
            ),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: _secondaryBtn(Icons.quiz, 'Review Test', () {}),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _secondaryBtn(
                    Icons.restart_alt, 'Start at Unit 1', onStart),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _celebrationHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 144,
              height: 144,
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  secondaryFixed.withOpacity(0.4),
                  primaryFixed.withOpacity(0.3),
                  tertiaryFixed.withOpacity(0.4),
                ]),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: primaryFixed.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.flutter_dash, size: 72, color: primary),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.celebration,
                    size: 20, color: onSecondaryContainer),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.verified, size: 16, color: primary),
            const SizedBox(width: 4),
            Text('PLACEMENT ASSESSED',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: primary,
                    letterSpacing: 0.5)),
          ]),
        ),
        const SizedBox(height: 8),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: onSurface,
                letterSpacing: -0.5),
            children: [
              const TextSpan(text: 'Wadụna! '),
              TextSpan(text: 'Test Complete', style: TextStyle(color: primary)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "We've tailored your learning journey along the sacred Nun River based on your diagnostic score.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _rewardRibbon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
              child: _rewardChip('🐚', '+${profile.cowries} Cowries',
                  'Mastery Bonus', secondaryFixed)),
          const SizedBox(width: 8),
          Expanded(
              child: _rewardChip('🔥', '${profile.streak}-Day Boost',
                  'Streak Ignited', secondaryFixedDim.withOpacity(0.4))),
        ],
      ),
    );
  }

  Widget _rewardChip(String icon, String title, String sub, Color bg) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child:
                Center(child: Text(icon, style: const TextStyle(fontSize: 16))),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: secondary)),
              Text(sub,
                  style: TextStyle(fontSize: 11, color: onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _diagnosticCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.psychology_alt, color: primary, size: 22),
            const SizedBox(width: 8),
            const Text('Diagnostic Breakdown',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  color: primary, borderRadius: BorderRadius.circular(999)),
              child: Text('${profile.xp ~/ 15 * 20}% Score',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: onPrimary)),
            ),
          ]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: surfaceContainerLowest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('YOUR ASSESSED LEVEL',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: onSurfaceVariant,
                              letterSpacing: 0.5)),
                      const SizedBox(height: 4),
                      Row(children: [
                        Text('Tọrọ Kpọrọ',
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: primary)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: tertiaryFixed,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(profile.level,
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: onTertiaryFixed)),
                        ),
                      ]),
                      const SizedBox(height: 4),
                      Text(
                          'Intermediate Beginner • Natural ear for Central Izon rhythm.',
                          style:
                              TextStyle(fontSize: 12, color: onSurfaceVariant)),
                    ],
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryFixedDim.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.explore, color: primary, size: 28),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _learningPath() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Text('Custom Learning Path',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5)),
          const Spacer(),
          const Icon(Icons.tune, size: 16, color: primary),
          Text(' Optimized',
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700, color: primary)),
        ]),
        const SizedBox(height: 10),
        _pathItem(
          icon: Icons.check,
          iconBg: primary.withOpacity(0.2),
          iconColor: primary,
          tag: 'Tested Out',
          tagBg: surfaceContainerHighest,
          tagColor: onSurfaceVariant,
          title: 'Basic Greetings & Courtesy',
          sub: 'Ebiete, Dọọ, Nua & Elder address',
          trailing: 'Skipped',
        ),
        Center(
          child: Transform.translate(
            offset: const Offset(0, -4),
            child: Container(
              width: 24,
              height: 24,
              decoration:
                  BoxDecoration(color: tertiary, shape: BoxShape.circle),
              child:
                  const Icon(Icons.arrow_downward, size: 14, color: onTertiary),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: tertiaryFixed,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: tertiaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.sailing,
                      color: onTertiaryContainer, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: onTertiaryFixed,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.star,
                              size: 13, color: tertiaryFixed),
                          const SizedBox(width: 3),
                          Text('Recommended Start',
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: tertiaryFixed)),
                        ]),
                      ),
                      const SizedBox(height: 4),
                      const Text('Unit 2: Beni & Fiyai',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: onTertiaryFixed)),
                      Text('The River, Fisherfolk Traditions & Market Living',
                          style: TextStyle(
                              fontSize: 13,
                              color: onTertiaryFixed.withOpacity(0.9))),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tertiaryFixedDim.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(children: [
                  const Icon(Icons.lock_open, size: 18, color: onTertiaryFixed),
                  const SizedBox(width: 6),
                  Text('Unlocked 14 River Lessons',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: onTertiaryFixed)),
                  const Spacer(),
                  Text('Pọọn Now',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: onTertiaryFixed)),
                  const Icon(Icons.chevron_right,
                      size: 16, color: onTertiaryFixed),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pathItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String tag,
    required Color tagBg,
    required Color tagColor,
    required String title,
    required String sub,
    required String trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: tagBg,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(tag,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: tagColor)),
                  ),
                  const SizedBox(width: 6),
                  Text('Unit 1',
                      style: TextStyle(fontSize: 11, color: onSurfaceVariant)),
                ]),
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700)),
                Text(sub,
                    style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(trailing,
                style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
          ),
        ],
      ),
    );
  }

  Widget _secondaryBtn(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: outlineVariant, offset: Offset(0, 3), blurRadius: 0)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: onSurface),
            const SizedBox(width: 6),
            Text(label,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
