import 'package:flutter/material.dart';
import '../models/learner_profile.dart';
import '../theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.profile});
  final LearnerProfile profile;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showLeaderboard = true;

  static const _leaders = [
    ('👑', 'Tariemi D.', 'Amassoma Central', 7, 2150),
    ('🥈', 'Kemenanabo K.', 'Ogobiri Waters', 6, 1920),
    ('🥉', 'YOU', 'Amasomo Scholar', 4, 0),
    ('4', 'Boma W.', 'Otuan Creek', 3, 1680),
    ('5', 'Ayebatari J.', 'Peremabiri', 3, 1520),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      children: [
        _profileHero(),
        const SizedBox(height: 16),
        _statsGrid(),
        const SizedBox(height: 16),
        _tabSwitcher(),
        const SizedBox(height: 12),
        if (_showLeaderboard) _leaderboardView() else _badgesView(),
        const SizedBox(height: 16),
        _heritageFooter(),
      ],
    );
  }

  Widget _profileHero() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Row(children: [
          Stack(children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                color: surfaceContainerHighest, shape: BoxShape.circle),
              child: const Icon(Icons.person, size: 44, color: onSurfaceVariant),
            ),
            Positioned(
              bottom: 0, right: 0,
              child: Container(
                width: 28, height: 28,
                decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
                child: const Icon(Icons.verified, size: 16, color: onPrimary),
              ),
            ),
          ]),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(widget.profile.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: secondaryFixed, borderRadius: BorderRadius.circular(999)),
                  child: const Text('Pro',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: onSecondaryFixed)),
                ),
              ]),
              Text('@${widget.profile.name.toLowerCase().replaceAll(' ', '_')}',
                  style: TextStyle(fontSize: 13, color: onSurfaceVariant)),
              Row(children: [
                Icon(Icons.calendar_month, size: 14, color: onSurfaceVariant),
                const SizedBox(width: 4),
                Text('Bayelsa Day 2024',
                    style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
              ]),
            ]),
          ),
        ]),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: surfaceContainerLowest.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            const Text('🛶', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Wadụna! (Keep rowing)',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: primary)),
                Text('3 more lessons to top rank Tariemi',
                    style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: primary, borderRadius: BorderRadius.circular(999)),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Text('Paddle', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: onPrimary)),
                SizedBox(width: 3),
                Icon(Icons.arrow_forward, size: 13, color: onPrimary),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _statsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: [
        _statCard('🔥', 'Day Streak', '${widget.profile.streak}', '(Best: 14)',
            secondaryFixed.withOpacity(0.3), secondaryFixed),
        _statCard('⚡', 'Total XP', '${widget.profile.xp}', '',
            primaryFixed.withOpacity(0.3), primaryFixed),
        _statCard('🐚', 'Cowries', '${widget.profile.cowries}', '',
            tertiaryFixed.withOpacity(0.4), tertiaryFixed),
        _statCard('🏆', 'League Rank', '#3 Brass', '',
            surfaceContainerHigh, secondaryContainer),
      ],
    );
  }

  Widget _statCard(String icon, String label, String value, String sub,
      Color bg, Color iconBg) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Center(child: Text(icon, style: const TextStyle(fontSize: 18))),
        ),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(fontSize: 11, color: onSurfaceVariant)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          if (sub.isNotEmpty)
            Text(sub, style: TextStyle(fontSize: 10, color: onSurfaceVariant)),
        ]),
      ]),
    );
  }

  Widget _tabSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: surfaceContainerHigh, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Expanded(child: _tab('Village Leaderboard', _showLeaderboard, () => setState(() => _showLeaderboard = true))),
        Expanded(child: _tab('Badges & Heritage', !_showLeaderboard, () => setState(() => _showLeaderboard = false))),
      ]),
    );
  }

  Widget _tab(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active ? surfaceContainerLowest : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: active ? primary : onSurfaceVariant)),
        ),
      ),
    );
  }

  Widget _leaderboardView() {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [tertiary, tertiaryContainer]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: surfaceContainerLowest.withOpacity(0.2), shape: BoxShape.circle),
            child: const Center(child: Text('🌊', style: TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Brass River Division',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: onTertiary)),
              Text('Top 3 advance to Nun River League in 2d 14h',
                  style: TextStyle(fontSize: 12, color: tertiaryFixedDim)),
            ]),
          ),
          const Icon(Icons.info_outline, color: tertiaryFixed, size: 22),
        ]),
      ),
      const SizedBox(height: 10),
      ..._leaders.asMap().entries.map((entry) {
        final i = entry.key;
        final l = entry.value;
        final isMe = l.$2 == 'YOU';
        final xp = isMe ? widget.profile.xp : l.$5;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? primaryFixed.withOpacity(0.2) : surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: isMe ? Border(left: BorderSide(color: primary, width: 4)) : null,
          ),
          child: Row(children: [
            SizedBox(
              width: 32,
              child: Center(
                child: Text(l.$1,
                    style: TextStyle(
                        fontSize: i < 3 ? 20 : 16,
                        fontWeight: FontWeight.w700,
                        color: onSurfaceVariant)),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: isMe ? primary : surfaceContainer, shape: BoxShape.circle),
              child: Center(
                child: isMe
                    ? const Icon(Icons.person, color: onPrimary, size: 22)
                    : Text(l.$2.substring(0, 2),
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(isMe ? widget.profile.name : l.$2,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isMe ? primary : onSurface)),
                  if (isMe) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: primary, borderRadius: BorderRadius.circular(999)),
                      child: const Text('YOU',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: onPrimary)),
                    ),
                  ],
                ]),
                Text(l.$3, style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
              ]),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('$xp',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isMe ? primary : onSurface)),
              Text('XP', style: TextStyle(fontSize: 11, color: onSurfaceVariant)),
            ]),
          ]),
        );
      }),
    ]);
  }

  Widget _badgesView() {
    final badges = [
      ('🛶', 'River Pathfinder', 'Navigated 40 maritime and river delta phrases.', 1.0, 'Tier 2'),
      ('👑', "Elder's Blessing", 'Mastered 25 traditional Izon respect greetings.', 1.0, 'Unlocked'),
      ('🧺', 'Market Master', 'Amassoma waterside market trade & bargaining.', 0.53, 'In Progress'),
    ];
    return Column(children: [
      Row(children: [
        const Text('Cultural Badges',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: primary.withOpacity(0.1), borderRadius: BorderRadius.circular(999)),
          child: Text('3 Earned / 12 Total',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: primary)),
        ),
      ]),
      const SizedBox(height: 10),
      ...badges.map((b) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Row(children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              color: surfaceContainerHigh, borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(b.$1, style: const TextStyle(fontSize: 28))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(b.$2, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: surfaceContainerHighest, borderRadius: BorderRadius.circular(999)),
                  child: Text(b.$5,
                      style: TextStyle(fontSize: 11, color: onSurfaceVariant)),
                ),
              ]),
              Text(b.$3, style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: b.$4,
                  backgroundColor: surfaceContainerHigh,
                  color: primary,
                  minHeight: 6,
                ),
              ),
            ]),
          ),
        ]),
      )),
    ]);
  }

  Widget _heritageFooter() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surfaceContainer, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: primary.withOpacity(0.1), shape: BoxShape.circle),
          child: const Center(child: Text('🌿', style: TextStyle(fontSize: 22))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Izon Language Heritage',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text(
              'Your daily learning safeguards the coastal voices of Bayelsa for future generations.',
              style: TextStyle(fontSize: 13, color: onSurfaceVariant),
            ),
          ]),
        ),
      ]),
    );
  }
}
