import 'package:nike_project/features/data/models/banner_model.dart';
import 'package:nike_project/features/data/source/ibanners_repository_remote_source.dart';
import 'package:nike_project/packages/dio/dio_package.dart';

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
  Future<List<BannerModel>> getAllBanners() async =>
      await iBannerRepositoryRemoteSource.getAllBanners();
}
