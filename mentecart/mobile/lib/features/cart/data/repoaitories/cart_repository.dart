import 'package:dio/dio.dart';
import 'package:mobile/core/network/dio_client.dart';

class CartRepository {

  final Dio dio = DioClient.dio;

  Future<void> addToCart({
    required String token,
    required String serviceId,
    required String date,
    required String timeSlot,
    required int quantity,
  }) async {

    await dio.post(
      '/cart/items',

      data: {
        'serviceId': serviceId,
        'date': date,
        'timeSlot': timeSlot,
        'quantity': quantity,
      },

      options: Options(
        headers: {
          'Authorization':
              'Bearer $token',
        },
      ),
    );
  }
}