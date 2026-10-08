import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/learner_profile.dart';
import '../theme.dart';
import '../widgets/tactile_button.dart';

class LearningPathPage extends StatelessWidget {
  const LearningPathPage({
    super.key,
    required this.profile,
    required this.onStartLesson,
  });
  final LearnerProfile profile;
  final VoidCallback onStartLesson;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      children: [
        _dailyQuestPill(),
        const SizedBox(height: 12),
        _unitBanner(),
        const SizedBox(height: 20),
        _pathMap(context),
        const SizedBox(height: 20),
        _unit2Teaser(),
      ],
    );
  }

  Widget _dailyQuestPill() {
    return Container(
      padding: const EdgeInsets.all(12),
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
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: secondaryFixed,
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                const Center(child: Text('⚡', style: TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DAILY QUEST',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: secondary,
                        letterSpacing: 0.5)),
                const Text('Score 90%+ in 1 lesson',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: surfaceContainerHigh,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Text('🐚', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 3),
              Text('+20',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: tertiary)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _unitBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: onPrimary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.local_florist,
                            size: 14, color: primaryFixed),
                        const SizedBox(width: 4),
                        Text('Unit 1 • Foundation',
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: primaryFixed,
                                letterSpacing: 0.5)),
                      ]),
                    ),
                    const SizedBox(height: 6),
                    const Text('Greetings & Everyday Respect',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: onPrimary)),
                    Text('Ebimi nua & Doooo',
                        style: TextStyle(
                            fontSize: 13,
                            color: const Color(0xFFF7FFF2).withOpacity(0.9))),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFF005320),
                        offset: Offset(0, 4),
                        blurRadius: 0)
                  ],
                ),
                child:
                    const Icon(Icons.auto_stories, color: onPrimary, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: onPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Step ${profile.currentLesson} of 5 lessons',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: onPrimary)),
                          Text('${profile.currentLesson * 20}%',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: primaryFixed)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: profile.currentLesson / 5,
                          backgroundColor: onPrimary.withOpacity(0.2),
                          color: primaryFixed,
                          minHeight: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: onPrimary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [
                    Text('🌴', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 4),
                    Text('Bayelsa',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: onPrimary)),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pathMap(BuildContext context) {
    const totalNodes = 50;
    const nodeHeight = 135.0;
    final nodes = List.generate(totalNodes, (index) {
      final id = index + 1;
      final isChest = id % 5 == 0;
      final y = index * nodeHeight;
      final xOffset = math.sin(index * 0.7) * 0.55;

      return (
        id: id,
        top: y,
        alignX: xOffset,
        title: isChest ? 'Cowrie Chest' : '$id. Core Lesson $id',
        sub: isChest ? '' : 'Vocabulary Expansion',
        isChest: isChest,
      );
    });

    final totalHeight = totalNodes * nodeHeight;

    return SizedBox(
      height: totalHeight + 100,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomPaint(
            size: Size(double.infinity, totalHeight),
            painter: _PathPainter(totalNodes, nodeHeight),
          ),
          for (final node in nodes)
            Positioned(
              top: node.top,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment(node.alignX, 0),
                child: _buildNode(context, node),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNode(
      BuildContext context,
      ({
        int id,
        double top,
        double alignX,
        String title,
        String sub,
        bool isChest
      }) node) {
    if (node.id < profile.currentLesson) {
      if (node.isChest) return _lockedChestNode();
      return _completedNode(node.title, '${node.sub} • Mastered');
    }
    if (node.id == profile.currentLesson) {
      if (node.isChest) return _lockedChestNode();
      return _activeNode(context, node.title, node.sub);
    }
    if (node.isChest) {
      return _lockedChestNode();
    }
    return _lockedNode(node.title);
  }

  Widget _completedNode(String title, String sub) {
    return Column(
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: const [
          Text('⭐', style: TextStyle(fontSize: 14)),
          Text('⭐', style: TextStyle(fontSize: 18)),
          Text('⭐', style: TextStyle(fontSize: 14)),
        ]),
        const SizedBox(height: 4),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: primary,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                  color: Color(0xFF005320), offset: Offset(0, 8), blurRadius: 0)
            ],
          ),
          child: Center(
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                  color: primaryContainer, shape: BoxShape.circle),
              child: const Icon(Icons.check, color: onPrimary, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: surfaceContainerLowest,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Column(children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            Text(sub, style: TextStyle(fontSize: 11, color: primary)),
          ]),
        ),
      ],
    );
  }

  Widget _activeNode(BuildContext context, String title, String subtitle) {
    return Column(
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
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
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: primary)),
                  Text("Let's learn together! 🌿",
                      style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: secondaryFixed,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.flutter_dash, size: 32, color: secondary),
            ),
          ]),
        ]),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: primaryFixedDim.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
            GestureDetector(
              onTap: onStartLesson,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFF005320),
                        offset: Offset(0, 10),
                        blurRadius: 0)
                  ],
                ),
                child: const Icon(Icons.play_arrow, color: onPrimary, size: 40),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onStartLesson,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: secondaryContainer,
              borderRadius: BorderRadius.circular(999),
              boxShadow: const [
                BoxShadow(color: secondary, offset: Offset(0, 4), blurRadius: 0)
              ],
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Text('START',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: onSecondaryFixed)),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: surfaceContainerLowest.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('+15 XP',
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: secondary)),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 4),
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _lockedChestNode() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: outlineVariant, offset: Offset(0, 6), blurRadius: 0)
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Text('🐚', style: TextStyle(fontSize: 28)),
              Positioned(
                top: 4,
                right: 4,
                child: Icon(Icons.lock, size: 14, color: outline),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: surfaceContainerLowest,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text('Cowrie Chest',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: secondary)),
            Text(' • 50 🐚',
                style: TextStyle(fontSize: 11, color: onSurfaceVariant)),
          ]),
        ),
      ],
    );
  }

  Widget _lockedNode(String title) {
    return Opacity(
      opacity: 0.85,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: surfaceContainer,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                    color: outlineVariant, offset: Offset(0, 6), blurRadius: 0)
              ],
            ),
            child: Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    color: surfaceContainerHigh, shape: BoxShape.circle),
                child: Icon(Icons.lock, color: outline, size: 22),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: surfaceContainerHigh,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(title,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: onSurfaceVariant)),
          ),
        ],
      ),
    );
  }

  Widget _unit2Teaser() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: tertiaryFixed,
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                const Center(child: Text('🛶', style: TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text('Next: Unit 2',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: tertiary,
                          letterSpacing: 0.5)),
                  const SizedBox(width: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: surfaceContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('Locked',
                        style: TextStyle(fontSize: 11, color: outline)),
                  ),
                ]),
                const Text('The River, Fishing & Market Living',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                Text('Beni & Fiyai • Waterways culture',
                    style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration:
                BoxDecoration(color: surfaceContainer, shape: BoxShape.circle),
            child: Icon(Icons.lock, color: outline, size: 18),
          ),
        ],
      ),
    );
  }
}

class _PathPainter extends CustomPainter {
  _PathPainter(this.totalNodes, this.nodeHeight);
  final int totalNodes;
  final double nodeHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDAE2FD)
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    final xCenter = size.width / 2;
    // Align scales between -1 and +1 with 0 as center.
    // So 0.55 means 55% of the distance from the center to the edge.
    final maxOffset = size.width / 2;

    for (int i = 0; i < totalNodes; i++) {
      final y = i * nodeHeight + 50;
      final xOffset = math.sin(i * 0.7) * 0.55;
      final x = xCenter + (xOffset * maxOffset);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevY = (i - 1) * nodeHeight + 50;
        final prevXOffset = math.sin((i - 1) * 0.7) * 0.55;
        final prevX = xCenter + (prevXOffset * maxOffset);

        final cp1X = prevX;
        final cp1Y = prevY + nodeHeight / 1.5;
        final cp2X = x;
        final cp2Y = prevY + nodeHeight / 3;

        path.cubicTo(cp1X, cp1Y, cp2X, cp2Y, x, y);
      }
    }

    canvas.drawPath(path, paint);

    final dashPaint = Paint()
      ..color = primary.withOpacity(0.3)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
