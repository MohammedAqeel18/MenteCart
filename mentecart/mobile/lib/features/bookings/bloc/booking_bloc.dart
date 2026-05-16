import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/bookings/bloc/booking_event.dart';
import 'package:mobile/features/bookings/bloc/booking_state.dart';
import 'package:mobile/features/bookings/data/repositories/booking_repository.dart';

export 'booking_event.dart';
export 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repository;

  BookingBloc(this.repository) : super(BookingInitial()) {
    on<FetchBookings>(_onFetchBookings);
    on<CancelBooking>(_onCancelBooking);
  }

  Future<void> _onFetchBookings(
    FetchBookings event,
    Emitter<BookingState> emit,
  ) async {
    try {
      emit(BookingLoading());
      final bookings = await repository.getBookings(
        token: event.token,
      );
      emit(BookingLoaded(bookings));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onCancelBooking(
    CancelBooking event,
    Emitter<BookingState> emit,
  ) async {
    try {
      emit(BookingLoading());
      await repository.cancelBooking(
        token: event.token,
        bookingId: event.bookingId,
      );
      add(FetchBookings(token: event.token));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}