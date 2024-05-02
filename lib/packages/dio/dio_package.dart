import 'package:dio/dio.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';

final httpClient =
    Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final authInfo = AuthRepositoryImpl.authChangeNotifier.value;
            if (authInfo != null && authInfo.accessToken.isNotEmpty) {
              options.headers['Authorization'] =
                  'Bearer ${authInfo.accessToken}';
            }
            handler.next(options);
          },
        ),
      );
