import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/cart_screen/cart_screen.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/home_screen.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/profile_screen/profile_screen.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

int homeIndex = 0;
int cartIndex = 1;
int profileIndex = 2;

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  @override
  void initState() {
    super.initState();
    cartRepository.count();
  }

  int selectedHomeIndex = homeIndex;
  final List<int> _history = [];
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedHomeIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedHomeIndex = _history.last;
        _history.removeLast();
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: selectedHomeIndex,
          children: [
            _navigator(_homeKey, homeIndex, const HomeScreen()),
            _navigator(_cartKey, cartIndex, const AddToCartScreen()),
            _navigator(_profileKey, profileIndex, const ProfileScreen()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedHomeIndex,
          onTap: (selectedIndex) {
            setState(() {
              _history.remove(selectedHomeIndex);
              _history.add(selectedHomeIndex);
              selectedHomeIndex = selectedIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                CupertinoIcons.house,
              ),
              label: LocaleKeys.home_text.tr(),
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    CupertinoIcons.cart,
                  ),
                  Positioned(
                    right: -8,
                    child: ValueListenableBuilder<int>(
                      valueListenable: CartRepositoryImp.cartItemCountNotifier,
                      builder: (context, value, child) => CartBadge(
                        value: value,
                        selectedHomeIndex: selectedHomeIndex,
                      ),
                    ),
                  ),
                ],
              ),
              label: LocaleKeys.cart_text.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                CupertinoIcons.person,
              ),
              label: LocaleKeys.profile_text.tr(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedHomeIndex != index
        ? const SizedBox()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => Offstage(
                offstage: selectedHomeIndex != index,
                child: child,
              ),
            ),
          );
  }
}

class CartBadge extends StatelessWidget {
  const CartBadge({
    super.key,
    required this.selectedHomeIndex,
    required this.value,
  });

  final int selectedHomeIndex;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value > 0,
      child: Container(
        width: 12,
        decoration: BoxDecoration(
          color: cartIndex != selectedHomeIndex
              ? kGreyColorShade600
              : Theme.of(context).textTheme.titleSmall!.color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            '$value',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: kWhiteColor),
          ),
        ),
      ),
    );
  }
}
