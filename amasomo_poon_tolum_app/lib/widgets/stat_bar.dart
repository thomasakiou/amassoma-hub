import 'package:flutter/material.dart';
import '../models/learner_profile.dart';
import '../theme.dart';

class StatBar extends StatelessWidget {
  const StatBar({super.key, required this.profile});
  final LearnerProfile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _chip('🔥', '${profile.streak}', const Color(0xFFFFFBEB),
            const Color(0xFFFDE68A), const Color(0xFFB45309)),
        const SizedBox(width: 6),
        _chip('🐚', '${profile.cowries}', surfaceContainerHigh,
            surfaceContainerHigh, tertiary),
        const SizedBox(width: 6),
        _chip('❤️', '${profile.hearts}', const Color(0xFFFFEDD5),
            const Color(0xFFFED7AA), const Color(0xFFC2410C)),
      ],
    );
  }

  Widget _chip(
      String icon, String label, Color bg, Color border, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 3),
          Text(label,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700, color: textColor)),
        ],
      ),
    );
  }
}
