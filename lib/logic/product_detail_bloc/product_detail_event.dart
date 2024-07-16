part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailEvent {}

class ProductCartButtonClickedEvent extends ProductDetailEvent {
  final ProductDataModel clickedProduct;

  ProductCartButtonClickedEvent({required this.clickedProduct});
}

class ProductWishlistButtonClickedEvent extends ProductDetailEvent {
  final ProductDataModel clickedProduct;
  ProductWishlistButtonClickedEvent({required this.clickedProduct});
}
