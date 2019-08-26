import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:network/src/base/config.dart';
import 'package:network/src/base/url_params.dart';
import 'package:network/src/base/http.dart';
import 'package:network/src/base/response.dart';
import 'package:network/src/base/status_mapper.dart';
import 'package:network/src/impl/http_client_adapter/adapter.dart' as customAdapter;

///Реализация Http на основе библиотеки [dio]
class DioHttp extends Http {
    final UrlParamsBuilder headersBuilder;
    final UrlParamsBuilder queryBuilder;
    final StatusCodeMapper errorMapper;

    final _dio = dio.Dio();

    DioHttp({
        this.headersBuilder,
        this.queryBuilder,
        HttpConfig config,
        this.errorMapper,
    }) : assert(headersBuilder != null) {
        _dio.options
            ..baseUrl = config.baseUrl
            ..connectTimeout = config.timeout.inMilliseconds
            ..receiveTimeout = config.timeout.inMilliseconds
            ..sendTimeout = config.timeout.inMilliseconds;

        //todo убрать после исправления сертификата на бэке
        _dio.httpClientAdapter = customAdapter.DefaultHttpClientAdapter();

        _dio.interceptors.add(dio.LogInterceptor(
            requestBody: true,
            responseBody: true,
        ));

        _dio.interceptors.add(dio.InterceptorsWrapper(onError: (e) {
            if (e.type == dio.DioErrorType.RESPONSE) {
                return e.response;
            }
            throw e;
        }));
    }

    @override
    Future<Response> get<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
    }) async {
        var headersMap = await _buildHeaders(url, headers);
        var queryMap = await _buildQuery(url, query);
        return _dio
            .get(
            url,
            queryParameters: queryMap,
            options: dio.Options(headers: headersMap),
        )
            .then(_toResponse);
    }

    @override
    Future<Response> post<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
        Map<String, dynamic> body,
    }) async {
        var headersMap = await _buildHeaders(url, headers);
        var queryMap = await _buildQuery(url, query);
        return _dio
            .post(
            url,
            queryParameters: queryMap,
            options: dio.Options(headers: headersMap),
            data: body,
        )
            .then(_toResponse);
    }

    @override
    Future<Response> put<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
        Map<String, dynamic> body,
    }) async {
        var headersMap = await _buildHeaders(url, headers);
        var queryMap = await _buildQuery(url, query);
        return _dio
            .put(
            url,
            queryParameters: queryMap,
            options: dio.Options(headers: headersMap),
            data: body,
        )
            .then(_toResponse);
    }

    @override
    Future<Response> delete<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
    }) async {
        var headersMap = await _buildHeaders(url, headers);
        var queryMap = await _buildQuery(url, query);
        return _dio
            .delete(
            url,
            queryParameters: queryMap,
            options: dio.Options(headers: headersMap),
        )
            .then(_toResponse);
    }

    @override
    Future<Response> patch<T>(String url, {
        Map<String, dynamic> query,
        Map<String, dynamic> headers,
        Map<String, dynamic> body,
    }) async {
        var headersMap = await _buildHeaders(url, headers);
        var queryMap = await _buildQuery(url, query);
        return _dio
            .patch(
            url,
            queryParameters: queryMap,
            options: dio.Options(headers: headersMap),
            data: body,
        )
            .then(_toResponse);
    }

    @override
    Future<Response> head<T>(String url,
        Map<String, dynamic> headers, {
            Map<String, dynamic> query,
        }) async {
        var headersMap = await _buildHeaders(url, headers);
        var queryMap = await _buildQuery(url, query);
        return _dio
            .head(
            url,
            queryParameters: queryMap,
            options: dio.Options(headers: headersMap),
        )
            .then(_toResponse);
    }

    @override
    Future<Response> multipart<T>(String url,
        Map<String, dynamic> headers, {
            Map<String, dynamic> query,
            List<File> body,
        }) async {
        var headersMap = await _buildHeaders(url, headers);
        var queryMap = await _buildQuery(url, query);

        List files = [];

        for (int i = 0; i < body.length; i++) {
            files.add(
                dio.UploadFileInfo(
                    body[i],
                    "image $i",
                    contentType: ContentType("image", "jpeg"),
                ),
            );
        }

        var data = dio.FormData.from({
            "files": files,
        });

        return _dio
            .post(
            url,
            data: data,
            options: dio.Options(headers: headersMap),
        )
            .then(_toResponse);
    }

    Future<Map<String, dynamic>> _buildHeaders(String url,
        Map<String, dynamic> headers) async =>
        await headersBuilder.buildForUrl(url, headers);

    Future<Map<String, dynamic>> _buildQuery(String url,
        Map<String, dynamic> query,) async =>
        queryBuilder != null
            ? await queryBuilder.buildForUrl(url, query)
            : query;

    Response _toResponse(dio.Response r) {
        final response = Response(r.data, r.statusCode);
        errorMapper.checkStatus(response);
        return response;
    }
}
