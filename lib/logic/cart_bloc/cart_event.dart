part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveFromCartEvent extends CartEvent {
  final ProductDataModel productDataModel;

  CartRemoveFromCartEvent({required this.productDataModel});
}

class CheckoutButtonClickedEvent extends CartEvent {}

//for calculating total
class CartIncrementQuantityEvent extends CartEvent {
  late final ProductDataModel productDataModel;

  CartIncrementQuantityEvent({required this.productDataModel});
}

class CartDecrementQuantityEvent extends CartEvent {
  late final ProductDataModel productDataModel;

  CartDecrementQuantityEvent({required this.productDataModel});
}
