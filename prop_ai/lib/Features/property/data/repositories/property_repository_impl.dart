import 'package:dartz/dartz.dart';
import 'package:prop_ai/core/error/failures.dart';

import '../../domain/entities/property_details_entity.dart';
import '../../domain/repositories/property_repository.dart';
import '../datasources/property_local_data_source.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyLocalDataSource localDataSource;

  PropertyRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, PropertyDetailsEntity>> getPropertyDetails(
    String propertyId,
  ) async {
    try {
      final result = await localDataSource.getPropertyDetails(propertyId);

      return Right(result);
    } catch (e) {
      return Left(
        UnknownFailure(
          message: 'Failed to load property details.',
          originalError: e,
        ),
      );
    }
  }
}
