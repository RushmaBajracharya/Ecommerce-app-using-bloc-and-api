import 'package:ecommerce_app_api/data/cart_items.dart';
import 'package:ecommerce_app_api/logic/product_detail_bloc/product_detail_bloc.dart';
import 'package:ecommerce_app_api/models/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItemsDetail extends StatelessWidget {
  final ProductDataModel productDataModel;
  final ProductDetailBloc productDetailBloc;
  const ProductItemsDetail({
    super.key,
    required this.productDataModel,
    required this.productDetailBloc,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.52,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productDataModel.title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '\$${productDataModel.price}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              Text(
                productDataModel.description!,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    bloc: productDetailBloc,
                    builder: (context, state) {
                      // Check if the product is carted in the state
                      final isCarted = state is ProductItemCartedActionState;

                      return Container(
                        width: 300,
                        height: 75,
                        decoration: BoxDecoration(
                            // Return the appropriate color based on carted status
                            color: isCarted
                                ? const Color.fromARGB(255, 108, 153, 190)
                                : Colors.blueGrey,
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    //to check if the item is already carted in cartItems
                    if (cartItems
                        .any((element) => element.id == productDataModel.id)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Center(
                              child: Text('Item Already Added to Cart',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black))),
                          backgroundColor: Color.fromARGB(255, 163, 236, 252)));
                    } else {
                      productDetailBloc.add(ProductCartButtonClickedEvent(
                        clickedProduct: productDataModel,
                      ));
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
