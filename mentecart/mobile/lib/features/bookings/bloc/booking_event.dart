import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBookings extends BookingEvent {
  final String token;

  FetchBookings({required this.token});

  @override
  List<Object> get props => [token];
}

class CancelBooking extends BookingEvent {
  final String token;
  final String bookingId;

  CancelBooking({
    required this.token,
    required this.bookingId,
  });

  @override
  List<Object> get props => [token, bookingId];
}