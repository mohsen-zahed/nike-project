import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/features/data/models/auth_info_model.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/registration_screen.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    if (isUserAthenticated) {
                      cartRepository.cartItemCountNotifier.value = 0;
                      authRepository.logout();
                    } else {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) => const RegistrationScreen()),
                      );
                    }
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
