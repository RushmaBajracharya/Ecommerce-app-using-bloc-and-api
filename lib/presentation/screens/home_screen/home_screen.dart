import 'package:ecommerce_app_api/logic/home_bloc/home_bloc.dart';
import 'package:ecommerce_app_api/presentation/screens/home_screen/common%20widgets/category_selection.dart';
import 'package:ecommerce_app_api/presentation/screens/home_screen/common%20widgets/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeBloc.add(HomeIntialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadingState):
            return const Scaffold(
              backgroundColor: const Color.fromARGB(255, 221, 249, 249),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case const (HomeLoadedSuccessState):
            final successState = state as HomeLoadedSuccessState;
            return SafeArea(
                child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 221, 249, 249),
              body: Column(children: [
                AppBar(),
                //for search bar
                SearchBar(),
                //for list of category
                const CategorySelection(),
                //for display all product items
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.60),
                      itemCount: successState.products.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                          homeBloc: homeBloc,
                          productDataModel: successState.products[index],
                          index: index,
                        );
                      }),
                ))
              ]),
            ));
          case const (HomeErrorState):
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  Padding SearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20)),
        child: const TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              fillColor: Colors.white,
              hintText: "Search....",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black26),
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: Colors.black26,
              )),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding AppBar() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Text(
            'QuickMart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ));
  }
}
