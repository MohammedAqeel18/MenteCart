import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
       ),
  );

  static String get _baseUrl {
  if(kIsWeb) return 'http://localhost:5000/api';

  return defaultTargetPlatform == TargetPlatform.android 
  ?'http://10.0.2.2:5000/api'
  :'http://localhost:5000/api';
}
}