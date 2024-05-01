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
    final AuthInfoModel authInfoModel = await iAuthDataSource.refreshToken(
        "def502002072cba8d933656230a32eda2603eddc72b457c2515e97465a9bafc7a261d1f8f46b3437db70dbd8d87aef6e5fd19a2d91f7f56ac9eda65b2eb2f029660211e9aaa54bfea0430517ead11b10fa8e1f9a501bd44d1f67a15c60760145af80248a42c5c1ba34e81c4655786a364fc96a2d3242ad83410dbdea6b707130f998bb6e39196e6a1fc68f1fc62154b7d0fcb7db39303199e84d9081cd9f0c345bb958a66d43f4056fba3d9d50ddc44a1e40156b651a84160f021d646e772b9d2e869a678bab4e19a90bb9274f670eb93cf36ab933e0e7b1795c04ae319b1189f54cca951156a08311775e9bba266ddec03c0a95aca65051d29a9103941c745f02f37899f125c8cecfbb99687f92bfc2ebc619da7ce08b8e21499744c3767ddeacc0082892351dc3c56f6aac4196cc4162b143e638978667722603d38e8163565691974f1003356cfa4afc327aaf7ba3f04c9ff51cb8157df0ac9bdc45603b13");
    _storeAuthInfo(authInfoModel);
  }

  Future<void> _storeAuthInfo(AuthInfoModel authInfoModel) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfoModel.accessToken);
    sharedPreferences.setString("refresh_token", authInfoModel.refreshToken);
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString('access_token') ?? '';
    final String refreshToken =
        sharedPreferences.getString('refresh_token') ?? '';
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value =
          AuthInfoModel(accessToken: accessToken, refreshToken: refreshToken);
    }
  }
}
