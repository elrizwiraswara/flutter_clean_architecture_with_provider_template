import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  String get errorMessage => "$statusCode Error $message";

  @override
  List<Object> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromException(APIException exception) : this(message: exception.message, statusCode: exception.statusCode);
}


class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});

  CacheFailure.fromException(APIException exception) : this(message: exception.message, statusCode: exception.statusCode);
}
