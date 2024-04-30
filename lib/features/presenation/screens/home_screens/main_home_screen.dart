import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/home_screen.dart';
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
  int selectedHomeIndex = homeIndex;
  final List<int> _history = [];
  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _cartKey = GlobalKey();
  GlobalKey<NavigatorState> _profileKey = GlobalKey();

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
          selectedItemColor: kSecondaryColor,
          unselectedItemColor: kGreyColor,
          // showSelectedLabels: true,
          // showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(color: kSecondaryColor),
          unselectedLabelStyle: const TextStyle(color: kGreyColor),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.house,
                color: selectedHomeIndex == homeIndex ? kBlueColor : kGreyColor,
              ),
              label: LocaleKeys.home_text.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.cart,
                color: selectedHomeIndex == cartIndex ? kBlueColor : kGreyColor,
              ),
              label: LocaleKeys.cart_text.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person,
                color:
                    selectedHomeIndex == profileIndex ? kBlueColor : kGreyColor,
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

class AddToCartScreen extends StatelessWidget {
  const AddToCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Cart Screen'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Screen'),
    );
  }
}
