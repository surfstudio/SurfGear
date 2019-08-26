import 'dart:io';
import 'package:network/src/base/response.dart';

///Фасад над работой с сетью
abstract class Http {
    ///GET- request
    Future<Response> get<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
    });

    ///POST-request
    Future<Response> post<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
        Map<String, dynamic> body,
    });

    ///PUT -request
    Future<Response> put<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
        Map<String, dynamic> body,
    });

    ///DELETE -request
    Future<Response> delete<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
    });

    ///PATCH -request
    Future<Response> patch<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
        Map<String, dynamic> body,
    });

    ///HEAD - request
    Future<Response> head<T>(String url,
        Map<String, dynamic> headers, {
            Map<String, dynamic> query,
        });

    /// Multipart request
    Future<Response> multipart<T>(String url,
        Map<String, dynamic> headers, {
            Map<String, dynamic> query,
            List<File> body,
        });

}
