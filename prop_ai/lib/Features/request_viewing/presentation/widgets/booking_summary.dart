import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/viewing_request_entity.dart';

class BookingSummary extends StatelessWidget {
  final ViewingRequestEntity request;

  const BookingSummary({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'BOOKING SUMMARY',
                style: AppTextStyle.semiBold10.copyWith(
                  color: AppColors.gray500,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'ID #${request.id.substring(request.id.length - 6)}',
                  style: AppTextStyle.semiBold10.copyWith(
                    color: AppColors.primary600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _SummaryRow(
            icon: Icons.home_outlined,
            label: 'Property',
            value: request.propertyTitle,
          ),

          _SummaryRow(
            icon: Icons.calendar_today_outlined,
            label: 'Date',
            value: _formatDate(request.date),
          ),

          _SummaryRow(
            icon: Icons.access_time,
            label: 'Time',
            value: request.time,
          ),

          const Divider(height: 24),

          Row(
            children: [
              Text(
                'Assigned Agent:',
                style: AppTextStyle.regular12.copyWith(
                  color: AppColors.gray500,
                ),
              ),
              const Spacer(),
              Text(request.agentName, style: AppTextStyle.semiBold12),
              const SizedBox(width: 4),
              Icon(Icons.verified, size: 13, color: AppColors.primary600),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary600),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: AppTextStyle.regular12.copyWith(color: AppColors.gray600),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.semiBold12,
            ),
          ),
        ],
      ),
    );
  }
}
