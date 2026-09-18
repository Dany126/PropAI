import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class RequestNotesField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RequestNotesField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Notes for Seller', style: AppTextStyle.semiBold14),
            const SizedBox(width: 4),
            Text(
              '(Optional)',
              style: AppTextStyle.regular12.copyWith(color: AppColors.gray500),
            ),
          ],
        ),

        const SizedBox(height: 8),

        TextField(
          maxLength: 250,
          maxLines: 4,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Mention any specific questions or preferred timing...',
            hintStyle: AppTextStyle.regular12.copyWith(
              color: AppColors.gray400,
            ),
            filled: true,
            fillColor: Colors.white,
            counterStyle: AppTextStyle.regular10.copyWith(
              color: AppColors.gray400,
            ),
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.gray200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.gray200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary600),
            ),
          ),
        ),
      ],
    );
  }
}
