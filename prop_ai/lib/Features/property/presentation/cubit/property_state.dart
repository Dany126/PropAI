import 'package:equatable/equatable.dart';

import '../../domain/entities/property_details_entity.dart';

enum PropertyStatus { initial, loading, success, failure }

class PropertyState extends Equatable {
  final PropertyStatus status;
  final PropertyDetailsEntity? property;
  final String? errorMessage;

  const PropertyState({
    this.status = PropertyStatus.initial,
    this.property,
    this.errorMessage,
  });

  PropertyState copyWith({
    PropertyStatus? status,
    PropertyDetailsEntity? property,
    String? errorMessage,
  }) {
    return PropertyState(
      status: status ?? this.status,
      property: property ?? this.property,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, property, errorMessage];
}
