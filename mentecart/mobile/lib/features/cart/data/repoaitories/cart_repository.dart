import 'package:dio/dio.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/cart/data/models/cart_model.dart';

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

  Future<List<CartItemModel>>
    getCartItems({
  required String token,
}) async {

  final response = await dio.get(
    '/cart',

    options: Options(
      headers: {
        'Authorization':
            'Bearer $token',
      },
    ),
  );

  final List items =
      response.data['data']['items'];

  return items
      .map(
        (item) =>
            CartItemModel.fromJson(item),
      )
      .toList();
}

Future<void> checkout({
  required String token,
}) async {

  await dio.post(
    '/bookings/checkout',

    options: Options(
      headers: {
        'Authorization':
            'Bearer $token',
      },
    ),
  );
}
}

