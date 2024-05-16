import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/config/constants/constant_variables.dart';
import 'package:nike_project/features/data/models/auth_info_model.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

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
    try {
      final response = await httpClient.post('auth/token', data: {
        "grant_type": "password",
        "client_id": 2,
        "client_secret": constantVariables.clientSecret,
        "username": username,
        "password": password,
      });
      if (response.statusCode != 200) {
        throw response.statusMessage.toString();
      }
      return AuthInfoModel(
        accessToken: response.data["access_token"],
        refreshToken: response.data["refresh_token"],
        email: username,
      );
    } catch (e) {
      debugPrint(e.toString());
      throw LocaleKeys.something_went_wrong.tr();
    }
  }

  @override
  Future<AuthInfoModel> refreshToken(String refreshToken) async {
    try {
      final response = await httpClient.post('auth/token', data: {
        "grant_type": "refresh_token",
        "refresh_token": refreshToken,
        "client_id": 2,
        "client_secret": constantVariables.clientSecret,
      });

      if (response.statusCode != 200) {
        throw response.statusMessage.toString();
      }
      return AuthInfoModel(accessToken: response.data["access_token"], refreshToken: response.data["refresh_token"], email: '');
    } catch (e) {
      debugPrint(e.toString());
      throw "User already submitted, refresh token expired";
    }
  }

  @override
  Future<AuthInfoModel> register(String username, String password) async {
    try {
      final response = await httpClient.post('user/register', data: {
        "email": username,
        "password": password,
      });

      if (response.statusCode != 200) {
        throw response.statusMessage.toString();
      }
      return login(username, password);
    } catch (e) {
      debugPrint(e.toString());
      throw LocaleKeys.something_went_wrong.tr();
    }
  }
}
