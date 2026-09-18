import 'package:equatable/equatable.dart';

class ViewingRequestEntity extends Equatable {
  final String id;

  final String propertyId;
  final String propertyTitle;
  final String propertyImage;
  final String propertyLocation;
  final String propertyType;
  final String propertyPrice;

  final String agentName;

  final DateTime date;
  final String time;

  final String? notes;

  final ViewingRequestStatus status;

  const ViewingRequestEntity({
    required this.id,
    required this.propertyId,
    required this.propertyTitle,
    required this.propertyImage,
    required this.propertyLocation,
    required this.propertyType,
    required this.propertyPrice,
    required this.agentName,
    required this.date,
    required this.time,
    required this.notes,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    propertyId,
    propertyTitle,
    propertyImage,
    propertyLocation,
    propertyType,
    propertyPrice,
    agentName,
    date,
    time,
    notes,
    status,
  ];
}

enum ViewingRequestStatus { pending, confirmed, cancelled }
