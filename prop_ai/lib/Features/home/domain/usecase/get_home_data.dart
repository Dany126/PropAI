import 'package:dartz/dartz.dart';
import 'package:prop_ai/core/error/failures.dart';
import 'package:prop_ai/core/usecase/usecase.dart';

import '../entities/home_data_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeData extends UseCase<HomeDataEntity, NoParams> {
  final HomeRepository repository;

  GetHomeData({required this.repository});

  @override
  Future<Either<Failure, HomeDataEntity>> call(NoParams params) {
    return repository.getHomeData();
  }
}
