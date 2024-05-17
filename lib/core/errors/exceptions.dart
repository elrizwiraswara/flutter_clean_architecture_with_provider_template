import 'package:equatable/equatable.dart';

class APIException extends Equatable implements Exception {
  const APIException({required this.error, this.code});

  final String error;
  final int? code;

  @override
  List<Object?> get props => [error, code];
}

class CacheException extends Equatable implements Exception {
  const CacheException({required this.error, this.code});

  final String error;
  final int? code;

  @override
  List<Object?> get props => [error, code];
}

class ServiceException extends Equatable implements Exception {
  const ServiceException({required this.error, this.code});

  final String error;
  final int? code;

  @override
  List<Object?> get props => [error, code];
}
