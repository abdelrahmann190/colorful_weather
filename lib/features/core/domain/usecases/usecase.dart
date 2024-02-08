import 'package:dartz/dartz.dart';
import 'package:colorful_weather/features/core/error/failures.dart';

abstract class UseCase<Type, P> {
  Future<Either<Failure, Type>> call(P params);
}

class NoParams {}
