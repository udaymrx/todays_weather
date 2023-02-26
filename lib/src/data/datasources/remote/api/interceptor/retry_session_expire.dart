import 'package:dio/dio.dart';

import '../../../../../core/exception/app_exception.dart';
import 'session_end_retrier.dart';

class RetryOnSessionExpiredInterceptor extends Interceptor {
  final SessionEndRetrier requestRetrier;

  RetryOnSessionExpiredInterceptor({
    required this.requestRetrier,
  });

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err)) {
      try {
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (_) {}
    }
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.unknown &&
        err.error != null &&
        err.error is AppExceptionUnauthorized;
  }
}
