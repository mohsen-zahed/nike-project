import 'package:nike_project/features/data/models/auth_info_model.dart';
import 'package:nike_project/features/data/source/iauth_data_source.dart';
import 'package:nike_project/packages/dio/dio_package.dart';

final authRepository = AuthRepositoryImpl(
  iAuthDataSource: AuthDataSourceImp(httpClient: httpClient),
);

abstract class IAuthRepository {
  Future<AuthInfoModel> login(String username, String password);
}

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthDataSource iAuthDataSource;

  AuthRepositoryImpl({required this.iAuthDataSource});
  @override
  Future<AuthInfoModel> login(String username, String password) =>
      iAuthDataSource.login(username, password);
}
