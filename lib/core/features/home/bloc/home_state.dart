part of 'home_bloc.dart';

final class HomeState extends Equatable {
  const HomeState({
    required this.apiState,
    required this.videos,
    this.isLastPage = false,
    this.currentPage = 1,
  });
  final List<HomeVideoModel> videos;
  final HomeAPIState apiState;
  final bool isLastPage;
  final int currentPage;

  @override
  List<Object> get props => [apiState, videos];

  factory HomeState.emty(HomeAPIState state) {
    return HomeState(
      apiState: state,
      videos: List.empty(growable: true),
    );
  }
  factory HomeState.update(HomeAPIState apiState, HomeState state) {
    return HomeState(
      apiState: apiState,
      videos: List.from(state.videos),
      currentPage: state.currentPage,
      isLastPage: state.isLastPage,
    );
  }
}
