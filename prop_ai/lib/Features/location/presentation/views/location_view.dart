import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/datasources/location_local_data_source.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/entities/location_entity.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';
import '../widgets/location_continue_button.dart';
import '../widgets/location_header.dart';
import '../widgets/location_option.dart';
import '../widgets/location_search_field.dart';

class LocationView extends StatelessWidget {
  final VoidCallback? onCompleted;

  const LocationView({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCubit(
        repository: LocationRepositoryImpl(
          localDataSource: LocationLocalDataSource(),
        ),
      )..loadSavedLocation(),
      child: LocationViewBody(onCompleted: onCompleted),
    );
  }
}

class LocationViewBody extends StatelessWidget {
  final VoidCallback? onCompleted;

  const LocationViewBody({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text(
          'Location',
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state.status == LocationStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<LocationCubit>();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                children: [
                  const LocationHeader(),

                  const SizedBox(height: 28),

                  LocationSearchField(cubit: cubit),

                  const SizedBox(height: 16),

                  _CurrentLocationButton(
                    loading: state.status == LocationStatus.loading,
                    onPressed: cubit.useCurrentLocation,
                  ),

                  const SizedBox(height: 24),

                  Expanded(
                    child: _LocationResults(
                      state: state,
                      onLocationSelected: cubit.selectLocation,
                    ),
                  ),

                  LocationContinueButton(
                    enabled: state.selectedLocation != null,
                    loading: state.status == LocationStatus.loading,
                    onPressed: () async {
                      await cubit.saveSelectedLocation();

                      if (!context.mounted) {
                        return;
                      }

                      if (context.read<LocationCubit>().state.status ==
                          LocationStatus.success) {
                        onCompleted?.call();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CurrentLocationButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPressed;

  const _CurrentLocationButton({
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: loading ? null : onPressed,
        icon: loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.my_location_rounded),
        label: Text(
          loading ? 'Getting your location...' : 'Use my current location',
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary600,
          side: const BorderSide(color: AppColors.primary600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

class _LocationResults extends StatelessWidget {
  final LocationState state;
  final ValueChanged<LocationEntity> onLocationSelected;

  const _LocationResults({
    required this.state,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (state.selectedLocation != null) {
      return ListView(
        children: [
          const Text(
            'Selected location',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.gray700,
            ),
          ),
          const SizedBox(height: 12),
          LocationOption(
            location: state.selectedLocation!,
            selected: true,
            onTap: () {},
          ),
        ],
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              size: 36,
              color: AppColors.primary600,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Choose your location',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.gray900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Search for a city or use your current location.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.gray600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
