import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_api/logic/navigation/constants/nav_bar_items.dart';
import 'package:ecommerce_app_api/logic/navigation/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavbarItem.home, 0));

  void getNavBarItem(NavbarItem navBarItem) {
    switch (navBarItem) {
      case NavbarItem.home:
        emit(const NavigationState(NavbarItem.home, 0));
        break;
      case NavbarItem.cart:
        emit(const NavigationState(NavbarItem.cart, 1));
        break;
      case NavbarItem.wishlist:
        emit(const NavigationState(NavbarItem.wishlist, 2));
        break;
    }
  }
}
