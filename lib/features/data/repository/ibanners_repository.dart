import 'package:dio/dio.dart';
import 'package:nike_project/features/data/models/banner_model.dart';
import 'package:nike_project/features/data/source/ibanners_repository_remote_source.dart';

final httpClient = Dio(BaseOptions(
  baseUrl: 'http://expertdevelopers.ir/api/v1/',
));

final bannerRepository = IBannerRepositoryImp(
    iBannerRepositoryRemoteSource:
        IBannerRepositoryRemoteSourceImp(httpClient: httpClient));

abstract class IBannerRepository {
  Future<List<BannerModel>> getAllBanners();
}

class IBannerRepositoryImp implements IBannerRepository {
  final IBannerRepositoryRemoteSource iBannerRepositoryRemoteSource;

  IBannerRepositoryImp({required this.iBannerRepositoryRemoteSource});

  @override
  Future<List<BannerModel>> getAllBanners() =>
      iBannerRepositoryRemoteSource.getAllBanners();
}
