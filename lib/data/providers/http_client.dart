import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../utils/app_constants.dart';
import 'app_exceptions.dart';
import 'dio_util_error.dart';



class HttpClient {
  late Dio _client;
  Map<String, dynamic> headers = {};

  HttpClient() {
    _client = Dio();
    _client.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future<void> _interceptor() async {
    headers['Content-Type'] = 'application/json';
    _client.options.headers = headers;
    _client.options.followRedirects = true;
    _client.options.validateStatus = (code) {
      return 200 <= code! && code <= 350;
    };
  }

  Future<dynamic> getWithPath(String url) async {
    return get(AppConstant.baseUrl + url);
  }

  Future<dynamic> get(String url) async {
    await _interceptor();
    dynamic responseJson;
    try {
      final response = await _client.get(url);
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      DioErrorUtil.handleError(e);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {dynamic body}) async {
    await _interceptor();
    dynamic responseJson;
    try {
      final response = await _client.post(
        url,
        data: body,
      );
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      DioErrorUtil.handleError(e);
    }
    return responseJson;
  }

  Future postWithPath(String path, {dynamic body}) async {
    return post(AppConstant.baseUrl + path, body: body);
  }

  Future<Response<dynamic>?> postWithHeader(String url, {dynamic body}) async {
    await _interceptor();
    Response? response;
    try {
      response = await _client.post(AppConstant.baseUrl + url, data: body);
    } on DioError catch (e) {
      DioErrorUtil.handleError(e);
    }
    return response;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 500:
      default:
        throw FetchDataException('${response.statusCode}');
    }
  }
}
