import 'dart:io';
import 'package:network/src/base/response.dart';
import 'package:rxdart/rxdart.dart';

///Фасад над работой с сетью с использование [rx]
abstract class RxHttp {
    ///GET- request
    Observable<Response> get<T>(String url, {
        Map<String, dynamic> query,
        Map<String, String> headers,
    });

    ///POST-request
    Observable<Response> post<T>(String url, {
        Map<String, dynamic> query,
        Map<String, String> headers,
        Map<String, dynamic> body,
    });

    ///PUT -request
    Observable<Response> put<T>(String url, {
        Map<String, dynamic> query,
        Map<String, String> headers,
        Map<String, dynamic> body,
    });

    ///DELETE -request
    Observable<Response> delete<T>(String url, {
        Map<String, dynamic> query,
        Map<String, String> headers,
    });

    ///PATCH -request
    Observable<Response> patch<T>(String url, {
        Map<String, dynamic> query,
        Map<String, String> headers,
        Map<String, dynamic> body,
    });

    ///HEAD - request
    Observable<Response> head<T>(String url,
        Map<String, dynamic> query, {
            Map<String, String> headers,
        });

    /// Multipart request
    Observable<Response> multipart<T>(String url, {
        Map<String, dynamic> query,
        Map<String, String> headers,
        List<File> body,
    });

}
