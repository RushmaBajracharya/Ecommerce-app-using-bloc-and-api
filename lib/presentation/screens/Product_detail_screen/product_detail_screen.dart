import 'package:ecommerce_app_api/data/wishlist_item.dart';
import 'package:ecommerce_app_api/logic/product_detail_bloc/product_detail_bloc.dart';
import 'package:ecommerce_app_api/presentation/screens/Product_detail_screen/widgets/product_detail_image.dart';
import 'package:ecommerce_app_api/presentation/screens/Product_detail_screen/widgets/product_item_detail.dart';
import 'package:ecommerce_app_api/models/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductDetailBloc productDetailBloc = ProductDetailBloc();
    final ProductDataModel productDataModel =
        ModalRoute.of(context)!.settings.arguments as ProductDataModel;

    var height = MediaQuery.of(context).size.height;

    return BlocListener<ProductDetailBloc, ProductDetailState>(
      bloc: productDetailBloc,
      listener: (context, state) {
        if (state is ProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 1),
            content: Center(
                child: Text('Item Added to Cart',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black))),
            backgroundColor: Color.fromARGB(255, 163, 236, 252),
          ));
        } else if (state is ProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 1),
            content: Center(
                child: Text('Item Added to Wishlist',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black))),
            backgroundColor: Color.fromARGB(255, 163, 236, 252),
          ));
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 221, 249, 249),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  //physics: const NScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: height + .2 * height,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        //for product detail images
                        Hero(
                          tag: productDataModel.image!,
                          child: ProductDetailImage(
                            imageUrl: productDataModel.image!,
                          ),
                        ),
                        //for product item more detail

                        ProductItemsDetail(
                            productDetailBloc: productDetailBloc,
                            productDataModel: productDataModel),

                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //favroite icon
                                CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 221, 249, 249),
                                  radius: 25,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      const Color.fromARGB(255, 221, 249, 249),
                                  child: IconButton(
                                    icon: BlocBuilder<ProductDetailBloc,
                                        ProductDetailState>(
                                      bloc: productDetailBloc,
                                      builder: (context, state) {
                                        // Check if the product is wishlisted in the state
                                        final isWishlisted = state
                                            is ProductItemWishlistedActionState;
                                        // Return the appropriate icon based on wishlisted status
                                        return Icon(
                                          isWishlisted
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          size: 30,
                                          color: isWishlisted
                                              ? Colors.red.shade400
                                              : null, // Change color to blue if wishlisted
                                        );
                                      },
                                    ),
                                    onPressed: () {
                                      //to check if the item is already added to wishlist
                                      if (wishlistItems.any((element) =>
                                          element.id == productDataModel.id)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 1),
                                                content: Center(
                                                    child: Text(
                                                        'Item Already Added to Wishlist',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black))),
                                                backgroundColor: Color.fromARGB(
                                                    255, 163, 236, 252)));
                                      } else {
                                        productDetailBloc.add(
                                            ProductWishlistButtonClickedEvent(
                                                clickedProduct:
                                                    productDataModel));
                                      }
                                    },
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),

              //Add to cart button
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: GestureDetector(
              //     child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
              //       bloc: productDetailBloc,
              //       builder: (context, state) {
              //         // Check if the product is carted in the state
              //         final isCarted = state is ProductItemCartedActionState;

              //         return Container(
              //           width: 300,
              //           height: 75,
              //           decoration: BoxDecoration(
              //               // Return the appropriate color based on carted status
              //               color: isCarted
              //                   ? const Color.fromARGB(255, 108, 153, 190)
              //                   : Colors.blueGrey,
              //               borderRadius: BorderRadius.circular(25)),
              //           child: const Center(
              //             child: Text(
              //               "Add to Cart",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.w700,
              //                   fontSize: 22,
              //                   color: Colors.white),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //     onTap: () {
              //       //to check if the item is already carted in cartItems
              //       if (cartItems
              //           .any((element) => element.id == productDataModel.id)) {
              //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //             duration: Duration(seconds: 1),
              //             content: Center(
              //                 child: Text('Item Already Added to Cart',
              //                     style: TextStyle(
              //                         fontSize: 20,
              //                         fontWeight: FontWeight.w500,
              //                         color: Colors.black))),
              //             backgroundColor: Color.fromARGB(255, 163, 236, 252)));
              //       } else {
              //         productDetailBloc.add(ProductCartButtonClickedEvent(
              //           clickedProduct: productDataModel,
              //         ));
              //       }
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
