import 'package:gozle_video_kids_v1/core/data/remote/dio_client.dart';
import 'package:gozle_video_kids_v1/core/models/home_video_model/home_video_model.dart';
import 'package:gozle_video_kids_v1/core/repositories/home_repo/home_repo.dart';
import 'package:gozle_video_kids_v1/utilities/constants/end_points.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl extends HomeRepo with DioClientMixin {
  Future<Map<String, dynamic>?> getVideos(int page) async {
    final response =
        await dio.get(endPoint: EndPoints.homeVideos, queryParameters: {
      'page': page,
      'amount': 15,
      'pk': 27,
    });

    if (response.success) {
      final nextPage = int.tryParse(
          Uri.parse(response.data[APIKeys.next] as String? ?? '')
                  .queryParameters[APIKeys.page] ??
              '');
      final data =
          ((response.data as Map<String, dynamic>)[APIKeys.results] as List)
              .map((e) => HomeVideoModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return {
        APIKeys.next: nextPage == null,
        APIKeys.data: data,
      };
    }
    return null;
  }
}
