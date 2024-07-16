part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

//for listeners
abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

//Build state
class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

//Action State
class HomeProductTileNavigatePageActionState extends HomeActionState {}
