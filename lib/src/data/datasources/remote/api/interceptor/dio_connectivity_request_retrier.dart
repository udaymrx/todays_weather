import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../../services/connectivity_service.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;

  final ConnectivityService connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();
    streamSubscription = connectivity.connectionChange.listen(
      (hasConnection) {
        if (hasConnection) {
          streamSubscription.cancel();

          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                  method: requestOptions.method,
                  sendTimeout: requestOptions.sendTimeout,
                  receiveTimeout: requestOptions.receiveTimeout,
                  extra: requestOptions.extra,
                  headers: requestOptions.headers,
                  responseType: requestOptions.responseType,
                  contentType: requestOptions.contentType,
                  validateStatus: requestOptions.validateStatus,
                  receiveDataWhenStatusError:
                      requestOptions.receiveDataWhenStatusError,
                  followRedirects: requestOptions.followRedirects,
                  maxRedirects: requestOptions.maxRedirects,
                  requestEncoder: requestOptions.requestEncoder,
                  responseDecoder: requestOptions.responseDecoder,
                  listFormat: requestOptions.listFormat),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
