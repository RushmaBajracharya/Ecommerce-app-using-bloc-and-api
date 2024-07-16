import 'package:ecommerce_app_api/logic/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app_api/models/home_product_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  const CartItemTile(
      {super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          //height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 45, // Adjust the radius as needed
                    child: ClipOval(
                      child: Image.network(
                        productDataModel.image!,
                        width:
                            90, // Double the radius to match the diameter of the circle
                        height: 90,
                        fit: BoxFit
                            .cover, // Use cover to fill the circular avatar
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Container(
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          productDataModel.title!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '\$${productDataModel.price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            cartBloc.add(CartRemoveFromCartEvent(
                                productDataModel: productDataModel));
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 25,
                            color: Colors.red,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 17,
                            child: IconButton(
                                onPressed: () {
                                  cartBloc.add(CartDecrementQuantityEvent(
                                    productDataModel: productDataModel,
                                  ));
                                },
                                icon: const Icon(CupertinoIcons.minus)),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            productDataModel.quantity.toString(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 17,
                            child: IconButton(
                                onPressed: () {
                                  cartBloc.add(CartIncrementQuantityEvent(
                                    productDataModel: productDataModel,
                                  ));
                                },
                                icon: const Icon(CupertinoIcons.plus)),

                            // Icon(CupertinoIcons.plus),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
