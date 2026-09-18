import 'package:equatable/equatable.dart';

import '../../domain/entities/viewing_request_entity.dart';

enum RequestViewingStatus { initial, ready, submitting, success, failure }

class RequestViewingState extends Equatable {
  final RequestViewingStatus status;

  final DateTime? selectedDate;
  final String? selectedTime;

  final String notes;

  final String? errorMessage;

  final ViewingRequestEntity? request;

  const RequestViewingState({
    this.status = RequestViewingStatus.initial,
    this.selectedDate,
    this.selectedTime,
    this.notes = '',
    this.errorMessage,
    this.request,
  });

  RequestViewingState copyWith({
    RequestViewingStatus? status,
    DateTime? selectedDate,
    String? selectedTime,
    String? notes,
    String? errorMessage,
    ViewingRequestEntity? request,
  }) {
    return RequestViewingState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      notes: notes ?? this.notes,
      errorMessage: errorMessage ?? this.errorMessage,
      request: request ?? this.request,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedDate,
    selectedTime,
    notes,
    errorMessage,
    request,
  ];
}
