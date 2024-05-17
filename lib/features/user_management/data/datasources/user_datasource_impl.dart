import 'dart:convert';

import 'package:flutter_clean_architecture_with_provider_template/core/errors/errors.dart';
import 'package:flutter_clean_architecture_with_provider_template/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/data/models/user_model.dart';
import 'package:flutter_clean_architecture_with_provider_template/services/apis/restful/restful_api.dart';
import 'package:http/http.dart' as http;

import '../../../../core/usecase/usecase.dart';
import 'user_datasource.dart';

class UserDatasourceImpl implements UserDatasource {
  const UserDatasourceImpl(this._client, this._api);

  final http.Client _client;
  final RestFulApi _api;

  @override
  Future<Result<List<UserModel>>> getAllUser() async {
    try {
      final res = await _client.get(
        Uri.parse(_api.getAllUser()),
        headers: _api.defaultHeaders(),
      );

      if (res.statusCode == 200) {
        var list = json.decode(res.body) as List;
        var data = list.map((e) => UserModel.fromJson(e)).toList();
        return Result.success(data);
      } else {
        return Result.error(APIError(error: res.body, code: res.statusCode));
      }
    } on Exception {
      rethrow;
    } catch (e) {
      throw APIException(error: e.toString());
    }
  }

  @override
  Future<Result<UserModel>> createUser(UserModel user) async {
    try {
      final res = await _client.post(
        Uri.parse(_api.createUser()),
        headers: _api.defaultHeaders(),
        body: user.toJson(),
      );

      if (res.statusCode == 200) {
        return Result.success(UserModel.fromJson(json.decode(res.body)));
      } else {
        return Result.error(APIError(error: res.body, code: res.statusCode));
      }
    } on Exception {
      rethrow;
    } catch (e) {
      throw APIException(error: e.toString());
    }
  }

  @override
  Future<Result<UserModel>> getUser(String userId) async {
    try {
      final res = await _client.get(
        Uri.parse(_api.getUser(userId)),
        headers: _api.defaultHeaders(),
      );

      if (res.statusCode == 200) {
        return Result.success(UserModel.fromJson(json.decode(res.body)));
      } else {
        return Result.error(APIError(error: res.body, code: res.statusCode));
      }
    } on Exception {
      rethrow;
    } catch (e) {
      throw APIException(error: e.toString());
    }
  }

  @override
  Future<Result<bool>> updateUser(UserModel user) async {
    try {
      final res = await _client.put(
        Uri.parse(_api.updateUser(user.id)),
        headers: _api.defaultHeaders(),
      );

      if (res.statusCode == 200) {
        return Result.success(true);
      } else {
        return Result.error(APIError(error: res.body, code: res.statusCode));
      }
    } on Exception {
      rethrow;
    } catch (e) {
      throw APIException(error: e.toString());
    }
  }

  @override
  Future<Result<bool>> deleteUser(String userId) async {
    try {
      final res = await _client.delete(
        Uri.parse(_api.deleteUser(userId)),
        headers: _api.defaultHeaders(),
      );

      if (res.statusCode == 200) {
        return Result.success(true);
      } else {
        return Result.error(APIError(error: res.body, code: res.statusCode));
      }
    } on Exception {
      rethrow;
    } catch (e) {
      throw APIException(error: e.toString());
    }
  }
}
