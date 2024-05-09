import 'package:flutter/material.dart';
import 'package:nike_project/features/data/models/auth_info_model.dart';
import 'package:nike_project/features/data/source/iauth_data_source.dart';
import 'package:nike_project/packages/dio/dio_package.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepositoryImpl(
  iAuthDataSource: AuthDataSourceImp(httpClient: httpClient),
);

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> register(String username, String password);
  Future<void> refreshToken();
  Future<void> logout();
}

class AuthRepositoryImpl implements IAuthRepository {
  static final ValueNotifier<AuthInfoModel?> authChangeNotifier =
      ValueNotifier(null);
  final IAuthDataSource iAuthDataSource;

  AuthRepositoryImpl({required this.iAuthDataSource});
  @override
  Future<void> login(String username, String password) async {
    final AuthInfoModel authInfoModel =
        await iAuthDataSource.login(username, password);
    _storeAuthInfo(authInfoModel);
  }

  @override
  Future<void> register(String username, String password) async {
    final AuthInfoModel authInfoModel =
        await iAuthDataSource.register(username, password);
    _storeAuthInfo(authInfoModel);
  }

  @override
  Future<void> refreshToken() async {
    if (authChangeNotifier.value != null) {
      final AuthInfoModel authInfoModel = await iAuthDataSource
          .refreshToken(authChangeNotifier.value!.refreshToken);
      debugPrint('refresh token is: ${authInfoModel.refreshToken}');
      _storeAuthInfo(authInfoModel);
    }
  }

  Future<void> _storeAuthInfo(AuthInfoModel authInfoModel) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfoModel.accessToken);
    sharedPreferences.setString("refresh_token", authInfoModel.refreshToken);
    sharedPreferences.setString("email", authInfoModel.email);
    loadAuthInfo();
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString('access_token') ?? '';
    final String refreshToken =
        sharedPreferences.getString('refresh_token') ?? '';
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthInfoModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        email: sharedPreferences.getString("email") ?? '',
      );
    }
  }

  @override
  Future<void> logout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
