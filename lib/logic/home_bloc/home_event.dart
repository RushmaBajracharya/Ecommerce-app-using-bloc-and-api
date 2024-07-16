part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

//to emit loading ,success or error state
class HomeIntialEvent extends HomeEvent {}

class HomeProductTileClickedNavigateEvent extends HomeEvent {}
