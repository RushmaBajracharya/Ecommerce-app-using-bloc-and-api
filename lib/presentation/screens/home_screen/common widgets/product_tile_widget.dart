import 'package:ecommerce_app_api/presentation/screens/Product_detail_screen/product_detail_screen.dart';
import 'package:ecommerce_app_api/models/home_product_data_model.dart';
import 'package:ecommerce_app_api/logic/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  final int index;
  const ProductTile(
      {super.key,
      required this.productDataModel,
      required this.homeBloc,
      required this.index});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Transform.translate(
        offset: Offset(0, index.isOdd ? 28 : 0),
        child: GestureDetector(
          onTap: () {
            homeBloc.add(HomeProductTileClickedNavigateEvent());
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductDetailScreen(),
                    settings: RouteSettings(arguments: productDataModel)));
          },
          child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Hero(
                        tag: productDataModel.image!,
                        child: Image.network(
                          productDataModel.image!,
                          height: size.height * 0.25,
                          width: size.width * 0.45,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productDataModel.title!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '\$${productDataModel.price}',
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ])),
        ));
  }
}
