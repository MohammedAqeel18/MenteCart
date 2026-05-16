import 'package:dio/dio.dart';

import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/bookings/data/models/booking_model.dart';



class BookingRepository {

  final Dio dio = DioClient.dio;

  Future<List<BookingModel>>
      getBookings({
    required String token,
  }) async {

    final response = await dio.get(
      '/bookings',

      options: Options(
        headers: {
          'Authorization':
              'Bearer $token',
        },
      ),
    );

    final List bookings =
        response.data['data'];

    return bookings
        .map(
          (booking) =>
              BookingModel.fromJson(
                booking,
              ),
        )
        .toList();
  }

  Future<void> cancelBooking({
    required String token,
    required String bookingId,
  }) async {

    await dio.post(
      '/bookings/$bookingId/cancel',

      options: Options(
        headers: {
          'Authorization':
              'Bearer $token',
        },
      ),
    );
  }
}