import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/features/data/models/auth_info_model.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/registration_screen.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  void initState() {
    cartRepository.getAll().then((value) {
      for (var i = 0; i < value.cartItems.length; i++) {
        debugPrint(value.cartItems[i].product.title);
        debugPrint(value.cartItems[i].product.id.toString());
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<AuthInfoModel?>(
        valueListenable: AuthRepositoryImpl.authChangeNotifier,
        builder: (context, authState, child) {
          bool isUserAthenticated =
              authState != null && authState.accessToken.isNotEmpty;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isUserAthenticated
                      ? LocaleKeys.welcome_text.tr()
                      : LocaleKeys.login_to_account_text.tr(),
                ),
                ElevatedButton(
                  onPressed: () {
                    isUserAthenticated
                        ? authRepository.logout()
                        : Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrationScreen()),
                          );
                  },
                  child: Text(
                    isUserAthenticated
                        ? LocaleKeys.logout_text.tr()
                        : LocaleKeys.login_text.tr(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await authRepository.refreshToken();
                  },
                  child: Text(
                    'Refresh token',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
