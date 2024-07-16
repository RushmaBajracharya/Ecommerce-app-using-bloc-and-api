part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailState {}

abstract class ProductDetailActionState extends ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductItemWishlistedActionState extends ProductDetailActionState {}

class ProductItemCartedActionState extends ProductDetailActionState {}
