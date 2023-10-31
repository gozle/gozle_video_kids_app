import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gozle_video_kids_v1/core/data/remote/interceptors/log_interceptor.dart';
import 'package:gozle_video_kids_v1/core/models/api/api_response_model.dart';
import 'package:gozle_video_kids_v1/utilities/constants/end_points.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

mixin DioClientMixin {
  final _DioClient _dio = _DioClient();
  _DioClient get dio => _dio;
}

class _DioClient {
  _DioClient({
    String? baseUrl,
    ResponseType? type,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? EndPoints.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
            responseType: type ?? ResponseType.json,
          ),
        )..interceptors.addAll(
            [
              LoggerInterceptor(),
              InterceptorsWrapper(
                onResponse: (res, handler) {
                  'end response'.log();
                  handler.next(res);
                },
                onRequest: (options, handler) async {
                  handler.next(options);
                },
                onError: (e, handler) async {
                  handler.next(e);
                },
              )
            ],
          );

  late final Dio _dio;

  Future<ApiResponse> post({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        endPoint,
        data: data,
        options: options,
        queryParameters: queryParameters.addLang(),
      );
      return ApiResponse.fromJson(res.data as Map<String, dynamic>, true);
    } catch (e, s) {
      'zero Step'.log();

      return _handleException(e, s);
    }
  }

  Future<ApiResponse> get({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.get<dynamic>(
        endPoint,
        data: data,
        options: options,
        queryParameters: queryParameters.addLang(),
        cancelToken: cancelToken,
      );

      return ApiResponse(data: res.data as Map<String, dynamic>, success: true);
    } catch (e, s) {
      'ERROR GET'.log();
      return _handleException(e, s);
    }
  }

  Future<ApiResponse> delete({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        endPoint,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      return ApiResponse.fromJson(response.data, true);
    } catch (e, s) {
      return _handleException(e, s);
    }
  }
}

ApiResponse _handleException(Object e, StackTrace? stack) {
  final isDioExeption = e is DioException;
  if (!isDioExeption) {
    return ApiResponse.unknownError(null);
  }
  if (e.error is SocketException) {
    'MY log Soceet Exeptionnn'.log();
    return ApiResponse(
      data: {},
      error: 'SocketExeption',
      message: 'Socket Exeption Show Some TellSomeThing',
      success: false,
    );
  }
  if (e.response != null && e.response!.data is Map) {
    '${e.requestOptions.data} MyDioExeption'.log();
    return ApiResponse.fromJson(
      e.response!.data,
      null,
    );
  }
  return ApiResponse.unknownError(null);
}
