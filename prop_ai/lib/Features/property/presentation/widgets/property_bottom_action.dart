import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class PropertyBottomAction extends StatelessWidget {
  final VoidCallback onRequestViewing;

  const PropertyBottomAction({super.key, required this.onRequestViewing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            offset: const Offset(0, -4),
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: onRequestViewing,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary600,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            'Request a Viewing',
            style: AppTextStyle.semiBold12.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
