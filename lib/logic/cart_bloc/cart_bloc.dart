import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_api/data/cart_items.dart';
import 'package:ecommerce_app_api/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
    on<CheckoutButtonClickedEvent>(checkoutButtonClickedEvent);
    on<CartIncrementQuantityEvent>(cartIncrementQuantityEvent);
    on<CartDecrementQuantityEvent>(cartDecrementQuantityEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> checkoutButtonClickedEvent(
      CheckoutButtonClickedEvent event, Emitter<CartState> emit) {
    emit(CheckoutButtonClickedState());
  }

  FutureOr<void> cartIncrementQuantityEvent(
      CartIncrementQuantityEvent event, Emitter<CartState> emit) {
    if (state is CartSuccessState) {
      final currentState = state as CartSuccessState;
      final index = currentState.cartItems.indexOf(event.productDataModel);
      if (index != -1) {
        final updatedItems =
            List<ProductDataModel>.from(currentState.cartItems);
        updatedItems[index] = updatedItems[index]
            .copyWith(quantity: updatedItems[index].quantity + 1);
        emit(CartSuccessState(cartItems: updatedItems));
      }
    }
  }

  FutureOr<void> cartDecrementQuantityEvent(
      CartDecrementQuantityEvent event, Emitter<CartState> emit) {
    if (state is CartSuccessState) {
      final currentState = state as CartSuccessState;
      final index = currentState.cartItems.indexOf(event.productDataModel);
      if (index != -1 && currentState.cartItems[index].quantity > 1) {
        final updatedItems =
            List<ProductDataModel>.from(currentState.cartItems);
        updatedItems[index] = updatedItems[index]
            .copyWith(quantity: updatedItems[index].quantity - 1);
        emit(CartSuccessState(cartItems: updatedItems));
      }
    }
  }
}
