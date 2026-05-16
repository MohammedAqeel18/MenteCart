import 'package:dio/dio.dart';

import 'package:mobile/core/network/dio_client.dart';

import 'package:mobile/features/services/data/models/service_model.dart';

class ServiceRepository {

  final Dio dio = DioClient.dio;

  Future<List<ServiceModel>>
      getServices() async {

    final response =
        await dio.get('/services');

    final List services =
        response.data['data']['services'];

    return services
        .map(
          (service) =>
              ServiceModel.fromJson(service),
        )
        .toList();
  }
}