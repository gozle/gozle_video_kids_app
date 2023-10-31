import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gozle_video_kids_v1/app/injection/setup.dart';
import 'package:gozle_video_kids_v1/core/models/home_video_model/home_video_model.dart';
import 'package:gozle_video_kids_v1/core/repositories/home_repo/home_repo.dart';
import 'package:gozle_video_kids_v1/utilities/constants/end_points.dart';
import 'package:gozle_video_kids_v1/utilities/constants/enums.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.emty(HomeAPIState.init));

  final _repo = getIt<HomeRepo>();
  Future<void> init({bool? forRefresh}) async {
    if (state.apiState != HomeAPIState.init &&
        state.apiState != HomeAPIState.error &&
        !(forRefresh ?? false)) return;
    emit(HomeState.emty(HomeAPIState.loading));
    final response = await _repo.getVideos(1);
    if (response != null) {
      final videos = response[APIKeys.data] as List<HomeVideoModel>;
      return emit(
        HomeState(
          apiState: HomeAPIState.succses,
          videos: List.from(videos),
          currentPage: state.currentPage + 1,
          isLastPage: response[APIKeys.next],
        ),
      );
    }

    emit(HomeState.emty(HomeAPIState.error));
  }

  Future<void> loadMore() async {
    if (state.isLastPage) return;
    emit(HomeState.update(HomeAPIState.loadingMore, state));
    final response = await _repo.getVideos(state.currentPage + 1);
    if (response != null) {
      final videos = response[APIKeys.data] as List<HomeVideoModel>;
      return emit(
        HomeState(
          apiState: HomeAPIState.succses,
          videos: List.from(state.videos)..addAll(videos),
          currentPage: state.currentPage + 1,
          isLastPage: response[APIKeys.next],
        ),
      );
    }
    emit(HomeState.update(HomeAPIState.errorMore, state));
  }
}
