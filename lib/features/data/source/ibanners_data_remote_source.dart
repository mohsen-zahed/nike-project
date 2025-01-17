import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:nike_project/config/exception/app_exception.dart';
import 'package:nike_project/features/data/models/banner_model.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

abstract class IBannerDataRemoteSource {
  Future<List<BannerModel>> getAllBanners();
}

class BannerDataRemoteSourceImp implements IBannerDataRemoteSource {
  final Dio httpClient;

  BannerDataRemoteSourceImp({required this.httpClient});
  @override
  Future<List<BannerModel>> getAllBanners() async {
    final response = await httpClient.get('banner/slider');
    if (response.statusCode != 200) {
      throw AppException(
        errorException: LocaleKeys.something_went_wrong.tr(),
      );
    }
    final banners = <BannerModel>[];
    (response.data as List).forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    return banners;
  }
}
