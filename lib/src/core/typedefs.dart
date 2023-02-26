import 'package:dartz/dartz.dart';

import 'exception/app_exception.dart';

typedef FutureEither<T> = Future<Either<AppException, T>>;
