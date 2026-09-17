import 'package:dartz/dartz.dart';
import 'package:prop_ai/core/error/failures.dart';

import '../entities/property_details_entity.dart';

abstract class PropertyRepository {
  Future<Either<Failure, PropertyDetailsEntity>>
      getPropertyDetails(
    String propertyId,
  );
}