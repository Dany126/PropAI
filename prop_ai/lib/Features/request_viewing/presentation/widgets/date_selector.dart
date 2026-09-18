import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DateSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final dates = List.generate(
      6,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select Date', style: AppTextStyle.bold16),
            Text(
              _monthYear(selectedDate ?? dates.first),
              style: AppTextStyle.semiBold12.copyWith(
                color: AppColors.primary600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dates.map((date) {
              final selected =
                  selectedDate != null && _sameDay(selectedDate!, date);

              return GestureDetector(
                onTap: () {
                  onDateSelected(date);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 56,
                  height: 68,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary600 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary600
                          : AppColors.gray200,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _dayName(date),
                        style: AppTextStyle.medium10.copyWith(
                          color: selected ? Colors.white : AppColors.gray500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${date.day}',
                        style: AppTextStyle.bold16.copyWith(
                          color: selected ? Colors.white : AppColors.gray800,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        if (selectedDate != null) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: AppColors.gray500),
              const SizedBox(width: 5),
              Text(
                'Selected: ${_fullDate(selectedDate!)}',
                style: AppTextStyle.regular12.copyWith(
                  color: AppColors.gray600,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  String _dayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return days[date.weekday - 1];
  }

  String _monthYear(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.year}';
  }

  String _fullDate(DateTime date) {
    return '${_dayName(date)}, ${_monthYear(date)}';
  }

  bool _sameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
