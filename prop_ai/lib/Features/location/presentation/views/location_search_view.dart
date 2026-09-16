import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';
import '../widgets/location_option.dart';
import '../widgets/location_search_field.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../domain/entities/location_entity.dart';

class LocationSearchView extends StatelessWidget {
  final VoidCallback? onCompleted;

  const LocationSearchView({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.gray900),
          onPressed: () {
            // Either go back to permission or pop entirely
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Choose your location',
          style: AppTextStyle.semiBold18.copyWith(color: AppColors.gray900),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          final cubit = context.read<LocationCubit>();

          return SafeArea(
            child: ResponsiveLayout(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocationSearchField(cubit: cubit),

                    const SizedBox(height: 24),

                    // Search Results or Default Sections
                    if (state.searchQuery.isNotEmpty) ...[
                      if (state.searchResults.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Center(
                            child: Text(
                              'No locations found',
                              style: AppTextStyle.medium14.copyWith(
                                color: AppColors.gray500,
                              ),
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.searchResults.length,
                          itemBuilder: (context, index) {
                            final location = state.searchResults[index];
                            return LocationOption(
                              location: location,
                              isRecent: false,
                              onTap: () async {
                                cubit.selectLocation(location);
                                await cubit.saveSelectedLocation();
                                if (context.mounted && onCompleted != null) {
                                  onCompleted!();
                                }
                              },
                            );
                          },
                        ),
                    ] else ...[
                      // Use Current Location Box
                      InkWell(
                        onTap: () async {
                          await cubit.useCurrentLocation();
                          await cubit.saveSelectedLocation();
                          if (context.mounted && onCompleted != null) {
                            onCompleted!();
                          }
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.gray200),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary50,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.my_location,
                                  color: AppColors.primary600,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Use current location',
                                            style: AppTextStyle.semiBold16
                                                .copyWith(
                                                  color: AppColors.gray900,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary50,
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                          child: Text(
                                            'Instant',
                                            style: AppTextStyle.medium10
                                                .copyWith(
                                                  color: AppColors.primary600,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Detect GPS location automatically',
                                      style: AppTextStyle.regular12.copyWith(
                                        color: AppColors.gray500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      if (state.popularCities.isNotEmpty) ...[
                        // Popular Cities
                        Row(
                          children: [
                            Text(
                              'Popular Cities',
                              style: AppTextStyle.semiBold18.copyWith(
                                color: AppColors.gray900,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.local_fire_department,
                              color: AppColors.error500,
                              size: 20,
                            ),
                            Text(
                              'Trending',
                              style: AppTextStyle.medium14.copyWith(
                                color: AppColors.error500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: state.popularCities.map((city) {
                              final isSelected =
                                  city ==
                                  'Dubai Marina'; // Hardcoded for design match
                              return InkWell(
                                onTap: () async {
                                  final location = LocationEntity(
                                    name: city,
                                    latitude: 0,
                                    longitude: 0,
                                  );
                                  cubit.selectLocation(location);
                                  await cubit.saveSelectedLocation();
                                  if (context.mounted && onCompleted != null) {
                                    onCompleted!();
                                  }
                                },
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.white
                                        : AppColors.gray50,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary500
                                          : AppColors.gray200,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: AppColors.primary600
                                                  .withValues(alpha: 0.1),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        city,
                                        style: AppTextStyle.medium14.copyWith(
                                          color: isSelected
                                              ? AppColors.primary600
                                              : AppColors.gray700,
                                        ),
                                      ),
                                      if (isSelected) ...[
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: AppColors.primary600,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],

                      if (state.recentLocations.isNotEmpty) ...[
                        // Recent & Suggested Locations
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent & Suggested Locations',
                              style: AppTextStyle.semiBold18.copyWith(
                                color: AppColors.gray900,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Clear recent',
                                style: AppTextStyle.medium14.copyWith(
                                  color: AppColors.gray500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.recentLocations.length,
                          itemBuilder: (context, index) {
                            final location = state.recentLocations[index];
                            return LocationOption(
                              location: location,
                              isRecent: index == 0,
                              onTap: () async {
                                cubit.selectLocation(location);
                                await cubit.saveSelectedLocation();
                                if (context.mounted && onCompleted != null) {
                                  onCompleted!();
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
