import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:ecommerce_app_api/logic/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app_api/logic/navigation/constants/nav_bar_items.dart';
import 'package:ecommerce_app_api/logic/navigation/navigation_cubit.dart';
import 'package:ecommerce_app_api/logic/navigation/navigation_state.dart';
import 'package:ecommerce_app_api/logic/wishlist_bloc/wishlist_bloc.dart';
import 'package:ecommerce_app_api/presentation/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_app_api/presentation/screens/home_screen/home_screen.dart';
import 'package:ecommerce_app_api/presentation/screens/wishlist_screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late final CartBloc cartBloc;
  late final WishlistBloc wishlistBloc;

  @override
  void initState() {
    super.initState();
    cartBloc = context.read<CartBloc>();
    wishlistBloc = context.read<WishlistBloc>();
    cartBloc.add(CartInitialEvent());
    wishlistBloc.add(WishlistInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BlocConsumer<NavigationCubit, NavigationState>(
          listener: (context, state) {
            // if (state is ProductItemCartedActionState ||
            //     state is ProductItemWishlistedActionState) {
            //   setState(() {

            //   });
            // }
          },
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.index,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: BlocConsumer<CartBloc, CartState>(
                      bloc: cartBloc,
                      listenWhen: (previous, current) =>
                          current is CartActionState,
                      buildWhen: (previous, current) =>
                          current is! CartActionState,
                      listener: (context, state) {
                        // if (state.runtimeType == CartSuccessState) {
                        //   setState(() {});
                        // }
                        // if (state is ProductItemCartedActionState &&
                        //     state is CartSuccessState) {
                        //   countcart = (state as CartSuccessState).cartItems.length;
                        // }
                      },
                      builder: (context, state) {
                        if (state.runtimeType == CartSuccessState &&
                            (state as CartSuccessState).cartItems.isNotEmpty) {
                          return badges.Badge(
                            position: BadgePosition.topEnd(top: -18, end: -10),
                            badgeContent: Text(
                              '${state.cartItems.length}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            child: const Icon(Icons.shopping_cart),
                          );
                        } else {
                          return const Icon(Icons.shopping_cart);
                        }
                      },
                    ),
                    label: 'Cart'),
                BottomNavigationBarItem(
                    icon: BlocConsumer<WishlistBloc, WishlistState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state.runtimeType == WishlistSuccessState &&
                            (state as WishlistSuccessState)
                                .wishlistItems
                                .isNotEmpty) {
                          return badges.Badge(
                            position: BadgePosition.topEnd(top: -18, end: -10),
                            badgeContent: Text(
                              '${state.wishlistItems.length}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            child: const Icon(Icons.favorite),
                          );
                        } else {
                          return const Icon(Icons.favorite);
                        }

                        //return Icon(Icons.favorite);
                      },
                    ),
                    label: 'Wishlist')
              ],
              onTap: (index) {
                if (index == 0) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.home);
                } else if (index == 1) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.cart);
                } else if (index == 2) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.wishlist);
                }
              },
            );
          },
        ),
        body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            if (state.navbarItem == NavbarItem.home) {
              return const HomeScreen();
            } else if (state.navbarItem == NavbarItem.cart) {
              return const CartScreen();
            } else if (state.navbarItem == NavbarItem.wishlist) {
              return const WishlistScreen();
            }
            return Container();
          },
        ));
  }
}
