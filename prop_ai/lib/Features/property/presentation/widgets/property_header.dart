import 'package:flutter/material.dart';

class PropertyHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final bool isFavorite;

  const PropertyHeader({
    super.key,
    required this.onBack,
    required this.onFavorite,
    required this.onShare,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CircleButton(icon: Icons.arrow_back, onTap: onBack),

            Row(
              children: [
                _CircleButton(icon: Icons.share_outlined, onTap: onShare),
                const SizedBox(width: 8),
                _CircleButton(
                  icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                  onTap: onFavorite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.95),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 21),
        ),
      ),
    );
  }
}
