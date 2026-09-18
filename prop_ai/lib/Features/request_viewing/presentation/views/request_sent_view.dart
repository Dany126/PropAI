import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/viewing_request_entity.dart';
import '../widgets/booking_summary.dart';

class RequestSentView extends StatelessWidget {
  final ViewingRequestEntity request;

  final VoidCallback? onViewRequests;
  final VoidCallback? onBackToProperty;

  const RequestSentView({
    super.key,
    required this.request,
    this.onViewRequests,
    this.onBackToProperty,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '● INSTANT DISPATCH',
                style: AppTextStyle.semiBold10.copyWith(
                  color: AppColors.primary600,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            children: [
              const Spacer(),

              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9FBE7),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2ECC71).withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  size: 42,
                  color: Color(0xFF16A765),
                ),
              ),

              const SizedBox(height: 28),

              Text(
                'Request Sent!',
                style: AppTextStyle.bold18.copyWith(fontSize: 26),
              ),

              const SizedBox(height: 10),

              Text(
                'The seller will confirm your viewing time shortly. '
                'You\'ll get a notification once it\'s accepted.',
                textAlign: TextAlign.center,
                style: AppTextStyle.regular14.copyWith(
                  color: AppColors.gray600,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              BookingSummary(request: request),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: onViewRequests ?? () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary600,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View My Requests',
                        style: AppTextStyle.semiBold14.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: onBackToProperty ?? () => Navigator.pop(context),
                child: Text(
                  'Back to Property',
                  style: AppTextStyle.semiBold12.copyWith(
                    color: AppColors.primary600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
