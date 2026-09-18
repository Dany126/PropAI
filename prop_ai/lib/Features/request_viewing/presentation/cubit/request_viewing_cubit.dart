import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/viewing_request_entity.dart';
import 'request_viewing_state.dart';

class RequestViewingCubit extends Cubit<RequestViewingState> {
  RequestViewingCubit()
    : super(RequestViewingState(status: RequestViewingStatus.ready));

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void selectTime(String time) {
    emit(state.copyWith(selectedTime: time));
  }

  void updateNotes(String notes) {
    emit(state.copyWith(notes: notes));
  }

  bool get canSubmit {
    return state.selectedDate != null && state.selectedTime != null;
  }

  Future<void> submitRequest({
    required String propertyId,
    required String propertyTitle,
    required String propertyImage,
    required String propertyLocation,
    required String propertyType,
    required String propertyPrice,
    required String agentName,
  }) async {
    if (!canSubmit) {
      return;
    }

    emit(state.copyWith(status: RequestViewingStatus.submitting));

    // Temporary local submission.
    // This will become the API call later.
    await Future.delayed(const Duration(milliseconds: 700));

    final request = ViewingRequestEntity(
      id: 'PV-${DateTime.now().millisecondsSinceEpoch}',
      propertyId: propertyId,
      propertyTitle: propertyTitle,
      propertyImage: propertyImage,
      propertyLocation: propertyLocation,
      propertyType: propertyType,
      propertyPrice: propertyPrice,
      agentName: agentName,
      date: state.selectedDate!,
      time: state.selectedTime!,
      notes: state.notes.isEmpty ? null : state.notes,
      status: ViewingRequestStatus.pending,
    );

    emit(
      state.copyWith(status: RequestViewingStatus.success, request: request),
    );
  }
}
