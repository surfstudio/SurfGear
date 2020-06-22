import 'dart:math';

import 'package:dio/dio.dart';
import 'package:mwwm_github_client/utils/exceptions.dart';

/// Http client based on Dio
class NetworkClient {
  final _dio = Dio();

  /// Handy method to make http GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      final Response<T> response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on Exception catch (e) {
      throw _mapException(e);
    }
  }

  /// Map third party exception to local
  Exception _mapException(Exception e) {
    if (e is DioError) {
      if (e.type == DioErrorType.DEFAULT) {
        return NoInternetException(message: e.error.toString());
      } else {
        // map other dio errors
      }
    } else {
      // map other exceptions
    }

    return e;
  }
}
