import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/location_local_data_source.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';
import 'location_permission_view.dart';
import 'location_search_view.dart';

class LocationView extends StatelessWidget {
  final VoidCallback onCompleted;

  const LocationView({super.key, required this.onCompleted});

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
  final VoidCallback onCompleted;

  const LocationViewBody({super.key, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state.status == LocationStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        if (state.showSearchScreen) {
          return LocationSearchView(onCompleted: onCompleted);
        }
        return LocationPermissionView(onCompleted: onCompleted);
      },
    );
  }
}
