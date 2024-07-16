import 'package:ecommerce_app_api/logic/wishlist_bloc/wishlist_bloc.dart';
import 'package:ecommerce_app_api/presentation/screens/wishlist_screen/widgets/wishlist_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
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
                    'Wishlist',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.blueGrey,
                  )
                ],
              ),
            ),
            body: BlocConsumer<WishlistBloc, WishlistState>(
              bloc: wishlistBloc,
              listenWhen: (previous, current) => current is WishlistActionState,
              buildWhen: (previous, current) => current is! WishlistActionState,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case (const (WishlistSuccessState)):
                    final successState = state as WishlistSuccessState;
                    if (state.wishlistItems.isEmpty) {
                      return const Center(
                        child: Text(
                          'Your wishlist is empty',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        itemCount: successState.wishlistItems.length,
                        padding: const EdgeInsets.all(10.0),
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.black26,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          return WishlistItemTile(
                            productDataModel: successState.wishlistItems[index],
                            wishlistBloc: wishlistBloc,
                          );
                        },
                      );
                    }
                  default:
                }
                return Container();
              },
            )));
  }
}
