import 'package:dartz/dartz.dart';
import 'package:prop_ai/core/error/failures.dart';
import 'package:prop_ai/core/usecase/usecase.dart';

import '../entities/property_details_entity.dart';
import '../repositories/property_repository.dart';

class GetPropertyDetails extends UseCase<PropertyDetailsEntity, String> {
  final PropertyRepository repository;

  GetPropertyDetails({required this.repository});

  @override
  Future<Either<Failure, PropertyDetailsEntity>> call(String propertyId) {
    return repository.getPropertyDetails(propertyId);
  }
}
