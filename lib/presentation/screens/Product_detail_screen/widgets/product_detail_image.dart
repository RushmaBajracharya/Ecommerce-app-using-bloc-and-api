import 'package:ecommerce_app_api/presentation/screens/Product_detail_screen/widgets/cure_image_side.dart';
import 'package:flutter/material.dart';

class ProductDetailImage extends StatelessWidget {
  final String imageUrl;
  const ProductDetailImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: CurveImageSide(),
      child: Align(
        alignment: Alignment.topCenter,
        child: Center(
          child: Image(
            fit: BoxFit.cover,
            height: size.height * 0.6,
            width: size.width,
            image: NetworkImage(imageUrl),
          ),
        ),
      ),
    );
  }
}
