import 'package:dio/dio.dart';
import 'package:nike_project/core/constants/client_secret.dart';
import 'package:nike_project/features/data/models/auth_info_model.dart';

abstract class IAuthDataSource {
  Future<AuthInfoModel> login(String username, String password);
  Future<AuthInfoModel> register(String username, String password);
  Future<AuthInfoModel> refreshToken(String refreshToken);
}

class AuthDataSourceImp implements IAuthDataSource {
  final Dio httpClient;

  AuthDataSourceImp({required this.httpClient});
  @override
  Future<AuthInfoModel> login(String username, String password) async {
    final response = await httpClient.post('auth/token', data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": ClientSecret.clientSecret,
      "username": username,
      "password": password,
    });
    if (response.statusCode != 200) {
      throw 'bad response';
    }
    return AuthInfoModel(
        accessToken: response.data["access_token"],
        refreshToken: response.data["refresh_token"]);
  }

  @override
  Future<AuthInfoModel> refreshToken(String refreshToken) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<AuthInfoModel> register(String username, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
