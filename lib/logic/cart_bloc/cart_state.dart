part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartSuccessState({required this.cartItems});
}

class CheckoutButtonClickedState extends CartActionState {}

// class CartSubtotalState extends CartState {
//   final double subtotal;

//   CartSubtotalState({required this.subtotal});
// }
