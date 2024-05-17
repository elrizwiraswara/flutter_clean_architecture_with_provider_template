import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Error extends Equatable {
  final String error;
  final int? code;

  const Error({required this.error, this.code});

  String get errorerror => "$code Error $error";

  @override
  List<Object?> get props => [error, code];
}

class APIError extends Error {
  const APIError({required super.error, super.code});

  APIError.fromException(APIException exception) : this(error: exception.error, code: exception.code);
}

class CacheError extends Error {
  const CacheError({required super.error, super.code});

  CacheError.fromException(CacheException exception) : this(error: exception.error, code: exception.code);
}

class ServiceError extends Error {
  const ServiceError({required super.error, super.code});

  ServiceError.fromException(ServiceException exception) : this(error: exception.error, code: exception.code);
}
