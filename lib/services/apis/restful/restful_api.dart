import 'package:dotenv/dotenv.dart';

class RestFulApi {
  RestFulApi._internal() {
    /// Load environment variables at runtime from a .env file.
    /// see https://pub.dev/packages/dotenv
    var env = DotEnv(includePlatformEnvironment: true)..load();

    _baseUrl = env['BASE_URL'];

    /// CRUD API for testing
    /// for details, see https://crudcrud.com
    /// _baseUrl = "https://crudcrud.com/api/557c9dd2db2045e4bd0b6b2afcaf7dbb";

    if (_baseUrl == null) {
      throw Exception("Failed to read base URL from .env");
    }
  }

  /// Make [RestFulApi] to be singleton
  static final RestFulApi _instance = RestFulApi._internal();

  factory RestFulApi() => _instance;

  /// Base URL, loaded from .env once when [RestFulApi] called or initiated
  String? _baseUrl;

  /// Headers
  Map<String, String>? defaultHeaders() => {'Content-Type': 'application/json'};
  Map<String, String>? authorizationHeaders(String token) =>
      {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

  /// Endpoints
  String getAllUser() => "$_baseUrl/users";
  String createUser() => "$_baseUrl/users/";
  String getUser(String userId) => "$_baseUrl/users/$userId";
  String updateUser(String userId) => "$_baseUrl/users/$userId";
  String deleteUser(String userId) => "$_baseUrl/users/$userId";

  /// Add your endpoints...
}
