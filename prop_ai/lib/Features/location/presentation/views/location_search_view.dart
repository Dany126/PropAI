import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';
import '../widgets/location_option.dart';
import '../widgets/location_search_field.dart';
import '../../domain/entities/location_entity.dart';

class LocationSearchView extends StatelessWidget {
  final VoidCallback? onCompleted;

  const LocationSearchView({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.read<LocationCubit>().cancelSearch();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.gray900),
            onPressed: () {
              context.read<LocationCubit>().cancelSearch();
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
                child: Column(
                  children: [
                    LocationSearchField(cubit: cubit),

                    const SizedBox(height: 24),

                    Expanded(
                      child: _SearchContent(
                        state: state,
                        cubit: cubit,
                        onCompleted: onCompleted,
                      ),
                    ),

                    _ContinueButton(
                      state: state,
                      cubit: cubit,
                      onCompleted: onCompleted,
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SearchContent extends StatelessWidget {
  final LocationState state;
  final LocationCubit cubit;
  final VoidCallback? onCompleted;

  const _SearchContent({
    required this.state,
    required this.cubit,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    if (state.searchQuery.trim().isNotEmpty) {
      return _SearchResults(
        state: state,
        cubit: cubit,
        onCompleted: onCompleted,
      );
    }

    return _DefaultLocations(state: state, cubit: cubit);
  }
}

class _SearchResults extends StatelessWidget {
  final LocationState state;
  final LocationCubit cubit;
  final VoidCallback? onCompleted;

  const _SearchResults({
    required this.state,
    required this.cubit,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isSearching) {
      return Skeletonizer(
        enabled: true,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return LocationOption(
              location: const LocationEntity(
                name: 'Loading location name...',
                country: 'Loading country...',
              ),
              isSelected: false,
              onTap: () {},
            );
          },
        ),
      );
    }

    if (state.searchResults.isEmpty) {
      return Center(
        child: Text(
          'No locations found',
          style: AppTextStyle.medium14.copyWith(color: AppColors.gray500),
        ),
      );
    }

    return ListView.builder(
      itemCount: state.searchResults.length,
      itemBuilder: (context, index) {
        final location = state.searchResults[index];

        final isSelected = state.selectedLocation == location;

        return LocationOption(
          location: location,
          isSelected: isSelected,
          onTap: () async {
            FocusScope.of(context).unfocus();
            cubit.updateSearchQuery('');
            cubit.selectLocation(location);
            await cubit.saveSelectedLocation();

            if (!context.mounted) return;

            final currentState = context.read<LocationCubit>().state;
            if (currentState.status == LocationStatus.success) {
              onCompleted?.call();
            }
          },
        );
      },
    );
  }
}

class _DefaultLocations extends StatelessWidget {
  final LocationState state;
  final LocationCubit cubit;

  const _DefaultLocations({required this.state, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (state.selectedLocation != null &&
            state.selectedLocation != state.currentLocation) ...[
          Text(
            'Selected Location',
            style: AppTextStyle.semiBold18.copyWith(color: AppColors.gray900),
          ),
          const SizedBox(height: 16),
          LocationOption(
            location: state.selectedLocation!,
            isSelected: true,
            onTap: () {},
          ),
          const SizedBox(height: 32),
        ],

        if (state.currentLocation != null) ...[
          Text(
            'Current Location',
            style: AppTextStyle.semiBold18.copyWith(color: AppColors.gray900),
          ),
          const SizedBox(height: 16),
          LocationOption(
            location: state.currentLocation!,
            isSelected: state.selectedLocation == state.currentLocation,
            onTap: () {
              cubit.selectLocation(state.currentLocation!);
            },
          ),
        ] else ...[
          _CurrentLocationOption(
            cubit: cubit,
            isLoading: state.status == LocationStatus.loading,
          ),
          const SizedBox(height: 32),
        ],

        if (state.popularCities.isNotEmpty) ...[
          Text(
            'Popular Cities',
            style: AppTextStyle.semiBold18.copyWith(color: AppColors.gray900),
          ),

          const SizedBox(height: 16),

          ...state.popularCities.map((city) {
            final location = LocationEntity(name: city);

            return LocationOption(
              location: location,
              isSelected: state.selectedLocation == location,
              onTap: () {
                cubit.selectLocation(location);
              },
            );
          }),
        ],

        if (state.recentLocations
            .where((loc) => loc != state.selectedLocation)
            .isNotEmpty) ...[
          const SizedBox(height: 32),

          Text(
            'Recent Locations',
            style: AppTextStyle.semiBold18.copyWith(color: AppColors.gray900),
          ),

          const SizedBox(height: 16),

          ImplicitlyAnimatedList<LocationEntity>(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            items: state.recentLocations
                .where((loc) => loc != state.selectedLocation)
                .toList(),
            areItemsTheSame: (a, b) => a.name == b.name,
            itemBuilder: (context, animation, location, index) {
              return SizeFadeTransition(
                sizeFraction: 0.7,
                curve: Curves.easeInOut,
                animation: animation,
                child: LocationOption(
                  location: location,
                  isRecent: true,
                  isSelected: state.selectedLocation == location,
                  onTap: () {
                    cubit.selectLocation(location);
                  },
                  onDelete: () {
                    cubit.deleteRecentLocation(location);
                  },
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}

class _CurrentLocationOption extends StatelessWidget {
  final LocationCubit cubit;
  final bool isLoading;

  const _CurrentLocationOption({required this.cubit, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: InkWell(
        onTap: isLoading ? null : cubit.useCurrentLocation,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
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
                    Text(
                      'Use current location',
                      style: AppTextStyle.semiBold16.copyWith(
                        color: AppColors.gray900,
                      ),
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

              const Icon(Icons.chevron_right_rounded, color: AppColors.gray400),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final LocationState state;
  final LocationCubit cubit;
  final VoidCallback? onCompleted;

  const _ContinueButton({
    required this.state,
    required this.cubit,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final hasSelection = state.selectedLocation != null;
    final isLoading = state.status == LocationStatus.loading;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: !hasSelection || isLoading
            ? null
            : () async {
                await cubit.saveSelectedLocation();

                if (!context.mounted) {
                  return;
                }

                final currentState = context.read<LocationCubit>().state;

                if (currentState.status == LocationStatus.success) {
                  onCompleted?.call();
                }
              },
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary600,
          disabledBackgroundColor: AppColors.gray200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Text(
                'Continue',
                style: AppTextStyle.semiBold16.copyWith(color: AppColors.white),
              ),
      ),
    );
  }
}
