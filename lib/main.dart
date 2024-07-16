import 'package:ecommerce_app_api/logic/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app_api/logic/navigation/navigation_cubit.dart';
import 'package:ecommerce_app_api/logic/wishlist_bloc/wishlist_bloc.dart';
import 'package:ecommerce_app_api/presentation/screens/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc(),
        ),
        BlocProvider<WishlistBloc>(
          create: (BuildContext context) => WishlistBloc(),
        ),
        BlocProvider<NavigationCubit>(
          create: (BuildContext context) => NavigationCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RootScreen(),
      ),
    );

    // BlocProvider<NavigationCubit>(
    //   create: (context) => NavigationCubit(),
    //   child: const MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: RootScreen(),
    //   ),
    // );
  }
}
