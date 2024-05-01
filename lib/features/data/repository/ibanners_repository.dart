import 'package:nike_project/features/data/models/banner_model.dart';
import 'package:nike_project/features/data/source/ibanners_data_remote_source.dart';
import 'package:nike_project/packages/dio/dio_package.dart';

final bannerRepository = BannerRepositoryImp(
    iBannerRepositoryRemoteSource:
        BannerDataRemoteSourceImp(httpClient: httpClient));

abstract class IBannerRepository {
  Future<List<BannerModel>> getAllBanners();
}

class BannerRepositoryImp implements IBannerRepository {
  final IBannerDataRemoteSource iBannerRepositoryRemoteSource;

  BannerRepositoryImp({required this.iBannerRepositoryRemoteSource});

  @override
  Future<List<BannerModel>> getAllBanners() async =>
      await iBannerRepositoryRemoteSource.getAllBanners();
}
