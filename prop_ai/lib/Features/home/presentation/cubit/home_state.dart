import 'package:equatable/equatable.dart';

import '../../domain/entities/home_data_entity.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final HomeDataEntity? data;
  final String? errorMessage;
  final int selectedTypeIndex;

  const HomeState({
    this.status = HomeStatus.initial,
    this.data,
    this.errorMessage,
    this.selectedTypeIndex = 0,
  });

  HomeState copyWith({
    HomeStatus? status,
    HomeDataEntity? data,
    String? errorMessage,
    int? selectedTypeIndex,
    bool clearError = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      selectedTypeIndex: selectedTypeIndex ?? this.selectedTypeIndex,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage, selectedTypeIndex];
}
