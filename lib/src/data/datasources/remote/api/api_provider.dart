import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/exception/app_exception.dart';
import '../../../../core/typedefs.dart';
import '../../../../services/connectivity_service.dart';
import 'interceptor/dio_connectivity_request_retrier.dart';
import 'interceptor/retry_interceptor.dart';

enum ContentType { urlEncoded, json, multipart }

final apiProvider = Provider<ApiProvider>((ref) {
  return ApiProvider();
});

class ApiProvider {
  ApiProvider() {
    _dio = Dio();
    _dio.options.sendTimeout = const Duration(milliseconds: 30000);
    _dio.options.connectTimeout = const Duration(milliseconds: 30000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 30000);
    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: _dio,
          connectivity: ConnectivityService(),
        ),
      ),
    );

    _dio.httpClientAdapter = IOHttpClientAdapter();

    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      return client
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
    };

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(requestBody: true));
    }

    _baseUrl = "https://api.openweathermap.org/data/2.5";
  }

  late Dio _dio;

  late String _baseUrl;

  FutureEither<dynamic> post(
    String path, {
    dynamic body,
    String? newBaseUrl,
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.urlEncoded,
  }) async {
    final hasConnection = await ConnectivityService().checkInternetConnection();
    if (!hasConnection) {
      return left(const AppException.connectivity());
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    } else {
      url = _baseUrl + path;
    }

    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.multipart) {
      content = 'multipart/form-data';
    } else if (contentType == ContentType.json) {
      content = 'application/json; charset=utf-8';
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };

    try {
      final response = await _dio.post(
        url,
        data: body ?? {},
        queryParameters: query,
        options: Options(validateStatus: (status) => true, headers: headers),
      );

      if (response.statusCode == null) {
        return left(const AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        return right(response.data);
      } else {
        // if (response.statusCode! == 404) {
        //   return const left(AppException.unauthorized());
        // } else
        if (response.statusCode! == 401) {
          return left(const AppException.unauthorized());
        } else if (response.statusCode! == 502) {
          return left(const AppException.error());
        } else {
          // debugPrint(rawResponse.data['error'].toString());
          // return left(
          //     AppException.errorWithMessage(rawResponse.data['error']));
          if (response.data != null) {
            if (response.data.runtimeType == String) {
              return left(AppException.errorWithMessage(response.data));
            } else if (response.data['error'] != null) {
              return left(AppException.errorWithMessage(
                  response.data['message'] ?? ''));
            } else if (response.data['message'] != null) {
              return left(AppException.errorWithMessage(
                  response.data['message'] ?? ''));
            } else {
              return left(const AppException.error());
            }
          } else {
            return left(const AppException.error());
          }
        }
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return left(const AppException.connectivity());
      }
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return left(const AppException.connectivity());
      }

      if (e.response != null) {
        if (e.response!.data['message'] != null) {
          return left(
              AppException.errorWithMessage(e.response!.data['message']));
        }
      }
      return left(
          AppException.errorWithMessage(e.message ?? "Something went wrong"));
    } on Error catch (e) {
      debugPrint(e.stackTrace.toString());
      return left(const AppException.error());
    }
  }

  FutureEither<dynamic> put(
    String path, {
    dynamic body,
    String? newBaseUrl,
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.urlEncoded,
  }) async {
    final hasConnection = await ConnectivityService().checkInternetConnection();
    if (!hasConnection) {
      return left(const AppException.connectivity());
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    } else {
      url = _baseUrl + path;
    }

    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.multipart) {
      content = 'multipart/form-data';
    } else if (contentType == ContentType.json) {
      content = 'application/json; charset=utf-8';
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };


    try {
      final response = await _dio.put(
        url,
        data: body ?? {},
        queryParameters: query,
        options: Options(validateStatus: (status) => true, headers: headers),
      );

      if (response.statusCode == null) {
        return left(const AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        return right(response.data);
      } else {
        // if (response.statusCode! == 404) {
        //         return left(const AppException.connectivity());
        // } else
        if (response.statusCode! == 401) {
          return left(const AppException.unauthorized());
        } else if (response.statusCode! == 502) {
          return left(const AppException.error());
        } else {
          if (response.data != null) {
            if (response.data.runtimeType == String) {
              return left(AppException.errorWithMessage(response.data));
            } else if (response.data['message'] != null) {
              return left(AppException.errorWithMessage(
                  response.data['message'] ?? ''));
            } else {
              return left(const AppException.error());
            }
          } else {
            return left(const AppException.error());
          }
        }
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return left(const AppException.connectivity());
      }
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return left(const AppException.connectivity());
      }

      if (e.response != null) {
        if (e.response!.data['message'] != null) {
          return left(
              AppException.errorWithMessage(e.response!.data['message']));
        }
      }
      return left(
          AppException.errorWithMessage(e.message ?? "Something went wrong"));
    } on Error catch (e) {
      debugPrint(e.stackTrace.toString());
      return left(const AppException.error());
    }
  }

  FutureEither<dynamic> delete(
    String path, {
    dynamic body,
    String? newBaseUrl,
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.urlEncoded,
  }) async {
    final hasConnection = await ConnectivityService().checkInternetConnection();
    if (!hasConnection) {
      return left(const AppException.connectivity());
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    } else {
      url = _baseUrl + path;
    }

    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.multipart) {
      content = 'multipart/form-data';
    } else if (contentType == ContentType.json) {
      content = 'application/json; charset=utf-8';
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };


    try {
      final response = await _dio.delete(
        url,
        data: body ?? {},
        queryParameters: query,
        options: Options(validateStatus: (status) => true, headers: headers),
      );

      if (response.statusCode == null) {
        return left(const AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        return right(response.data);
      } else {
        // if (response.statusCode! == 404) {
        //         return left(const AppException.connectivity());
        // } else
        if (response.statusCode! == 401) {
          return left(const AppException.unauthorized());
        } else if (response.statusCode! == 502) {
          return left(const AppException.error());
        } else {
          if (response.data != null) {
            if (response.data.runtimeType == String) {
              return left(AppException.errorWithMessage(response.data));
            } else if (response.data['message'] != null) {
              return left(AppException.errorWithMessage(
                  response.data['message'] ?? ''));
            } else {
              return left(const AppException.error());
            }
          } else {
            return left(const AppException.error());
          }
        }
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return left(const AppException.connectivity());
      }
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return left(const AppException.connectivity());
      }

      if (e.response != null) {
        if (e.response!.data['message'] != null) {
          return left(
              AppException.errorWithMessage(e.response!.data['message']));
        }
      }
      return left(
          AppException.errorWithMessage(e.message ?? "Something went wrong"));
    } on Error catch (e) {
      debugPrint(e.stackTrace.toString());
      return left(const AppException.error());
    }
  }

  FutureEither<dynamic> get(
    String path, {
    String? newBaseUrl,
    String? token,
    Map<String, dynamic>? query,
    Map<String, String>? newHeader,
    ContentType contentType = ContentType.json,
  }) async {
    final hasConnection = await ConnectivityService().checkInternetConnection();
    if (!hasConnection) {
      return left(const AppException.connectivity());
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    } else {
      url = _baseUrl + path;
    }

    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.json) {
      content = 'application/json; charset=utf-8';
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };

    if (newHeader != null) {
      headers[newHeader.keys.first] = newHeader.values.first;
    }

    try {
      final response = await _dio.get(
        url,
        queryParameters: query,
        options: Options(validateStatus: (status) => true, headers: headers),
      );
      // ignore: unnecessary_null_comparison
      if (response == null) {
        return left(const AppException.error());
      }
      if (response.statusCode == null) {
        return left(const AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        return right(response.data);
      } else {
        if (response.statusCode! == 404) {
          return left(const AppException.connectivity());
        } else if (response.statusCode! == 401) {
          return left(const AppException.unauthorized());
        } else if (response.statusCode! == 403) {
          if (response.data != null) {
            return left(AppException.errorWithMessage(response.data ?? ''));
          } else {
            return left(const AppException.error());
          }
        } else if (response.statusCode! == 502) {
          return left(const AppException.error());
        } else {
          if (response.data != null) {
            if (response.data.runtimeType == String) {
              return left(AppException.errorWithMessage(response.data));
            } else if (response.data['message'] != null) {
              return left(AppException.errorWithMessage(
                  response.data['message'] ?? ''));
            } else {
              return left(const AppException.error());
            }
          } else {
            return left(const AppException.error());
          }
        }
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return left(const AppException.connectivity());
      }
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return left(const AppException.connectivity());
      }
      return left(const AppException.error());
    }
  }
}
