import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/viewing_request_entity.dart';
import '../cubit/request_viewing_cubit.dart';
import '../cubit/request_viewing_state.dart';
import '../widgets/agent_card.dart';
import '../widgets/date_selector.dart';
import '../widgets/request_notes_field.dart';
import '../widgets/request_property_card.dart';
import '../widgets/time_slot_card.dart';

class RequestViewingView extends StatelessWidget {
  final String propertyId;
  final String propertyTitle;
  final String propertyImage;
  final String propertyLocation;
  final String propertyType;
  final String propertyPrice;

  final VoidCallback? onBack;
  final void Function(ViewingRequestEntity request)? onRequestSent;

  const RequestViewingView({
    super.key,
    required this.propertyId,
    required this.propertyTitle,
    required this.propertyImage,
    required this.propertyLocation,
    required this.propertyType,
    required this.propertyPrice,
    this.onBack,
    this.onRequestSent,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RequestViewingCubit(),
      child: _RequestViewingContent(
        propertyId: propertyId,
        propertyTitle: propertyTitle,
        propertyImage: propertyImage,
        propertyLocation: propertyLocation,
        propertyType: propertyType,
        propertyPrice: propertyPrice,
        onBack: onBack,
        onRequestSent: onRequestSent,
      ),
    );
  }
}

class _RequestViewingContent extends StatelessWidget {
  final String propertyId;
  final String propertyTitle;
  final String propertyImage;
  final String propertyLocation;
  final String propertyType;
  final String propertyPrice;

  final VoidCallback? onBack;

  final void Function(ViewingRequestEntity request)? onRequestSent;

  const _RequestViewingContent({
    required this.propertyId,
    required this.propertyTitle,
    required this.propertyImage,
    required this.propertyLocation,
    required this.propertyType,
    required this.propertyPrice,
    this.onBack,
    this.onRequestSent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: onBack ?? () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Request Viewing', style: AppTextStyle.bold18),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFE9FAF0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '● FAST AGENT\n   REPLY',
              style: AppTextStyle.semiBold10.copyWith(
                color: const Color(0xFF159447),
              ),
            ),
          ),
        ],
      ),

      body: BlocConsumer<RequestViewingCubit, RequestViewingState>(
        listener: (context, state) {
          if (state.status == RequestViewingStatus.success &&
              state.request != null) {
            onRequestSent?.call(state.request!);
          }
        },
        builder: (context, state) {
          final cubit = context.read<RequestViewingCubit>();

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequestPropertyCard(
                        image: propertyImage,
                        type: propertyType,
                        title: propertyTitle,
                        price: propertyPrice,
                        location: propertyLocation,
                      ),

                      const SizedBox(height: 18),

                      AgentCard(name: 'Emaar Authorized Rep'),

                      const SizedBox(height: 24),

                      DateSelector(
                        selectedDate: state.selectedDate,
                        onDateSelected: cubit.selectDate,
                      ),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select Time Slot', style: AppTextStyle.bold16),
                          Text(
                            '45 min duration',
                            style: AppTextStyle.regular10.copyWith(
                              color: AppColors.gray500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          TimeSlotCard(
                            label: 'Morning',
                            time: '10:00 AM',
                            selected: state.selectedTime == '10:00 AM',
                            onTap: () {
                              cubit.selectTime('10:00 AM');
                            },
                          ),
                          TimeSlotCard(
                            label: 'Afternoon',
                            time: '02:00 PM',
                            selected: state.selectedTime == '02:00 PM',
                            onTap: () {
                              cubit.selectTime('02:00 PM');
                            },
                          ),
                          TimeSlotCard(
                            label: 'Sunset Tour',
                            time: '05:00 PM',
                            selected: state.selectedTime == '05:00 PM',
                            onTap: () {
                              cubit.selectTime('05:00 PM');
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      RequestNotesField(onChanged: cubit.updateNotes),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),

              _ConfirmButton(
                enabled: cubit.canSubmit,
                loading: state.status == RequestViewingStatus.submitting,
                onPressed: () {
                  cubit.submitRequest(
                    propertyId: propertyId,
                    propertyTitle: propertyTitle,
                    propertyImage: propertyImage,
                    propertyLocation: propertyLocation,
                    propertyType: propertyType,
                    propertyPrice: propertyPrice,
                    agentName: 'Emaar Authorized Rep',
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final bool enabled;
  final bool loading;
  final VoidCallback onPressed;

  const _ConfirmButton({
    required this.enabled,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: const Offset(0, -4),
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: enabled && !loading ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary600,
              disabledBackgroundColor: AppColors.gray200,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Confirm Request',
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
      ),
    );
  }
}
