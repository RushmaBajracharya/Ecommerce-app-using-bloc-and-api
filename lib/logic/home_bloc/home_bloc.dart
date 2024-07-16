import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_api/logic/repos/posts_repo.dart';
import 'package:ecommerce_app_api/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeIntialEvent>(homeIntialEvent);
    on<HomeProductTileClickedNavigateEvent>(
        homeProductTileClickedNavigateEvent);
  }

  Future<FutureOr<void>> homeIntialEvent(
      HomeIntialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    List<ProductDataModel> products = await PostsRepo.fetchPosts();
    //print(products);
    emit(HomeLoadedSuccessState(products: products));

    //print(response.body);
  }
}

// emit(HomeLoadingState());
// await Future.delayed(const Duration(seconds: 0));
// emit(HomeLoadedSuccessState(
//     products: ClothingData.clothingProducts
//         .map((e) => ProductDataModel(
//             id: e['id'],
//             name: e['name'],
//             description: e['description'],
//             price: e['price'],
//             imageUrl: e['imageUrl']))
//         .toList()));

FutureOr<void> homeProductTileClickedNavigateEvent(
    HomeProductTileClickedNavigateEvent event, Emitter<HomeState> emit) {
  //print(' clicked');
  emit(HomeProductTileNavigatePageActionState());
}
