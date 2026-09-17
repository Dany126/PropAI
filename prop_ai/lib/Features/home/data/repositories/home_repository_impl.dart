import 'package:dartz/dartz.dart';
import 'package:prop_ai/core/error/failures.dart';

import '../../domain/entities/home_data_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, HomeDataEntity>> getHomeData() async {
    try {
      final result = await localDataSource.getHomeData();

      return Right(result);
    } catch (e) {
      return Left(
        UnknownFailure(message: 'Failed to load home data.', originalError: e),
      );
    }
  }
}
