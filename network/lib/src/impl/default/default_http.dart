import 'dart:convert' as json;

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:network/src/base/config.dart';
import 'package:network/src/base/url_params.dart';
import 'package:network/src/base/http.dart';
import 'package:network/src/base/response.dart';
import 'package:network/src/base/status_mapper.dart';

///Реализация Http на основе стандартного [http]
///todo по необходимости реализовать логику query
@Deprecated("Используй DioHttp")
class DefaultHttp extends Http {
    final UrlParamsBuilder headersBuilder;
    final HttpConfig config;
    final StatusCodeMapper errorMapper;

    DefaultHttp({this.headersBuilder, this.config, this.errorMapper});

    ///GET- request
    @override
    Future<Response> get<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
    }) async {
        print("DEV_WEB request : $url");
        Map<String, dynamic> headersMap = await _buildHeaders(url, headers);
        return http
            .get(
            url,
            headers: headersMap,
        )
            .timeout(config?.timeout)
            .then(_toResponse);
    }

    ///POST-request
    @override
    Future<Response> post<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
        Map<String, dynamic> body,
    }) async {
        print("DEV_WEB request : $url, $body | $headers");
        Map<String, dynamic> headersMap = await _buildHeaders(url, headers);
        return http
            .post(
            url,
            headers: headersMap,
            body: json.jsonEncode(body),
        )
            .then(_toResponse);
    }

    ///PUT -request
    @override
    Future<Response> put<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
        Map<String, dynamic> body,
    }) async {
        print("DEV_WEB request : $url, $body");
        Map<String, dynamic> headersMap = await _buildHeaders(url, headers);
        return http
            .put(
            url,
            headers: headersMap,
            body: json.jsonEncode(body),
        )
            .then(_toResponse);
    }

    ///DELETE -request
    @override
    Future<Response> delete<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
    }) async {
        print("DEV_WEB request : $url");
        Map<String, dynamic> headersMap = await _buildHeaders(url, headers);
        return http
            .delete(
            url,
            headers: headersMap,
        )
            .then(_toResponse);
    }

    ///PATCH -request
    @override
    Future<Response> patch<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
        Map<String, dynamic> body,
    }) async {
        print("DEV_WEB request : $url, $body");
        Map<String, dynamic> headersMap = await _buildHeaders(url, headers);
        return http
            .patch(
            url,
            headers: headersMap,
            body: json.jsonEncode(body),
        )
            .then(_toResponse);
    }

    ///HEAD - request
    @override
    Future<Response> head<T>(String url,
        Map<String, dynamic> headers, {
            Map<String, dynamic> query,
        }) async {
        print("DEV_WEB request : $url");
        Map<String, dynamic> headersMap = await _buildHeaders(url, headers);
        return http
            .head(
            url,
            headers: headersMap,
        )
            .then(_toResponse);
    }

    @override
    Future<Response> multipart<T>(String url,
        Map<String, dynamic> headers, {
            Map<String, dynamic> query,
            dynamic body,
        }) async {

        return Response(null, 0);
    }

    Future<Map<String, dynamic>> _buildHeaders(String url,
        Map<String, dynamic> headers) async {
        Map<String, dynamic> headersMap = Map();
        if (headersBuilder != null) {
            headersMap.addAll(await headersBuilder.buildForUrl(url, headers));
        }

        Logger.d("request  headers: $url, | $headersMap");
        return headersMap;
    }


    Response _toResponse(http.Response r) {
        Logger.d("${r.statusCode} | ${r.body}");
        final response = Response(json.jsonDecode(r.body), r.statusCode);
        if (response.statusCode == 400) {
            mapError(response);
        }
        return response;
    }

    dynamic mapError(Response e) {
        errorMapper?.checkStatus(e);
    }
}
