import 'package:dio/dio.dart';
import 'package:mobile/core/network/dio_client.dart';

class AuthRepository {
  final Dio dio = DioClient.dio;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/auth/login',
      data: {
        'email':email,
        'password':password,
      },
    );

    return response.data['data']['token'];
  }

  Future<String> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/auth/signup',
      data: {
        'name':name,
        'email':email,
        'password':password,
      },
    );

    return response.data['data']['token'];
  }

}