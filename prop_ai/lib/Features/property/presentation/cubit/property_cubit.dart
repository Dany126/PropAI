import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/get_property_details.dart';
import 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final GetPropertyDetails getPropertyDetails;

  PropertyCubit({required this.getPropertyDetails})
    : super(const PropertyState());

  Future<void> loadProperty(String propertyId) async {
    emit(state.copyWith(status: PropertyStatus.loading));

    final result = await getPropertyDetails(propertyId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: PropertyStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (property) {
        emit(
          state.copyWith(status: PropertyStatus.success, property: property),
        );
      },
    );
  }
}
