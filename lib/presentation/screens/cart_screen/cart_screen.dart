import 'package:ecommerce_app_api/logic/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app_api/presentation/screens/cart_screen/widgets/cart_item_tile.dart';
import 'package:ecommerce_app_api/presentation/screens/order_screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 221, 249, 249),
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 60,
              backgroundColor: const Color.fromARGB(255, 221, 249, 249),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cart',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.blueGrey,
                  )
                ],
              ),
            ),
            body: BlocConsumer<CartBloc, CartState>(
              bloc: cartBloc,
              listener: (context, state) {
                if (state is CheckoutButtonClickedState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderScreen()));
                }
              },
              listenWhen: (previous, current) => current is CartActionState,
              buildWhen: (previous, current) => current is! CartActionState,
              builder: (context, state) {
                // Check if the product is carted in the state
                final isCheckedout = state is CheckoutButtonClickedState;
                switch (state.runtimeType) {
                  case const (CartSuccessState):
                    final successState = state as CartSuccessState;
                    if (state.cartItems.isEmpty) {
                      return const Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      );
                    } else {
                      return Column(
                        //alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            height: size.height * 0.60,
                            child: ListView.separated(
                              itemCount: successState.cartItems.length,
                              padding: const EdgeInsets.all(10.0),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Colors.black26,
                                height: 1,
                              ),
                              itemBuilder: (context, index) {
                                return CartItemTile(
                                  productDataModel:
                                      successState.cartItems[index],
                                  cartBloc: cartBloc,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Payment:",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "\$109.95",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        width: size.width * 0.90,
                                        height: 75,
                                        decoration: BoxDecoration(
                                            color: isCheckedout
                                                ? const Color.fromARGB(
                                                    255, 108, 153, 190)
                                                : Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: const Center(
                                          child: Text(
                                            "Checkout",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        cartBloc
                                            .add(CheckoutButtonClickedEvent());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  default:
                }
                return Container();
              },
            )));
  }
}
