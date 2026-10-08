import 'package:flutter/material.dart';

class TactileButton extends StatefulWidget {
  const TactileButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color = const Color(0xFF006B2C),
    this.shadowColor = const Color(0xFF005320),
    this.textColor = Colors.white,
    this.icon,
    this.height = 56.0,
  });

  final String label;
  final VoidCallback onTap;
  final Color color;
  final Color shadowColor;
  final Color textColor;
  final IconData? icon;
  final double height;

  @override
  State<TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<TactileButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        height: widget.height,
        transform: Matrix4.translationValues(0, _pressed ? 4 : 0, 0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor,
              offset: Offset(0, _pressed ? 1 : 5),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: widget.textColor, size: 22),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
