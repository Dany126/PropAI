import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prop_ai/core/usecase/usecase.dart';

import 'home_state.dart';
import '../../domain/usecase/get_home_data.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeData getHomeData;

  HomeCubit({required this.getHomeData}) : super(const HomeState());

  Future<void> loadHome() async {
    emit(state.copyWith(status: HomeStatus.loading, clearError: true));

    final result = await getHomeData(const NoParams());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        emit(state.copyWith(status: HomeStatus.success, data: data));
      },
    );
  }

  void selectPropertyType(int index) {
    emit(state.copyWith(selectedTypeIndex: index));
  }
}
