import 'package:dio/dio.dart';
import 'package:nike/data/banner.dart';
import 'package:nike/data/common/http_respons_validator.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource
    with HttpResponsValidator
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);

  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('banner/slider');
    validateRespons(response);
    final List<BannerEntity> banners = [];
    (response.data as List).forEach((jsonObjct) {
      banners.add(BannerEntity.fromJson(jsonObjct));
    });
    return banners;
  }
}
