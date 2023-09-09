import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

class InputConverter {
  Either<Failure, int> stringToInt(String number) {
    try {
      final integer = int.parse(number);

      if (integer < 0) {
        throw FormatException();
      } else {
        return Right(integer);
      }
    } on FormatException {
      return Left(InputInvalidFailure());
    }
  }
}
