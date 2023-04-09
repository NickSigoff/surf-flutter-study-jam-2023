import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class UseCaseWithParam<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseWithoutParam<Type> {
  Future<Either<Failure, Type>> call();
}
