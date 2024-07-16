import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_api/data/cart_items.dart';
import 'package:ecommerce_app_api/data/wishlist_item.dart';
import 'package:ecommerce_app_api/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<ProductCartButtonClickedEvent>(productCartButtonClickedEvent);
    on<ProductWishlistButtonClickedEvent>(productWishlistButtonClickedEvent);
  }

  FutureOr<void> productCartButtonClickedEvent(
      ProductCartButtonClickedEvent event, Emitter<ProductDetailState> emit) {
    // print('cart product clicked');

    cartItems.add(event.clickedProduct);
    emit(ProductItemCartedActionState());
  }

  FutureOr<void> productWishlistButtonClickedEvent(
      ProductWishlistButtonClickedEvent event,
      Emitter<ProductDetailState> emit) {
    //print('wishlist product clicked');
    wishlistItems.add(event.clickedProduct);
    emit(ProductItemWishlistedActionState());
  }
}
