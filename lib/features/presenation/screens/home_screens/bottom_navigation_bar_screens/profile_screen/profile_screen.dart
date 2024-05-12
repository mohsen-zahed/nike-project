import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/images_paths.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/data/models/auth_info_model.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/profile_screen/order_history_screen/order_history_screen.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/registration_screen.dart';
import 'package:nike_project/functions/theme_checker.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isUserAthenticated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.profile_text.tr(),
        ),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder<AuthInfoModel?>(
          valueListenable: AuthRepositoryImpl.authChangeNotifier,
          builder: (context, authState, child) {
            isUserAthenticated =
                authState != null && authState.accessToken.isNotEmpty;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: kTransparentColor,
                    maxRadius: getMediaQueryHeight(context, 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: kGreyColor),
                        image: DecorationImage(
                          image: AssetImage(
                            ThemeChecker.isCurrentThemeLight(context)
                                ? ImagesPaths.darkAppLogoPath
                                : ImagesPaths.lightAppLogoPath,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    AuthRepositoryImpl.authChangeNotifier.value?.email ??
                        LocaleKeys.guest_user_text.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: getMediaQueryHeight(context, 0.04)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getMediaQueryWidth(
                            context, kDefaultPaddingWidth20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.favorite_border_rounded),
                        const SizedBox(width: 15),
                        Text(
                          LocaleKeys.favorites_list_text.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getMediaQueryHeight(context, 0.03)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getMediaQueryWidth(
                            context, kDefaultPaddingWidth20)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => const OrderHistoryScreen()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(CupertinoIcons.bag),
                          const SizedBox(width: 15),
                          Text(
                            LocaleKeys.order_history_text.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: getMediaQueryHeight(context, 0.03)),
                  GestureDetector(
                    onTap: () {
                      isUserAthenticated
                          ? showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(LocaleKeys.logout_short_text.tr()),
                                content: Text(
                                  LocaleKeys
                                      .sure_you_want_to_logout_from_account_text
                                      .tr(),
                                  style: const TextStyle(height: 2.5),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      LocaleKeys.no_text.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      CartRepositoryImp
                                          .cartItemCountNotifier.value = 0;
                                      Navigator.pop(context);
                                      await authRepository.logout();
                                    },
                                    child: Text(
                                      LocaleKeys.yes_text.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreen()),
                            );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            getMediaQueryWidth(context, kDefaultPaddingWidth20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(isUserAthenticated ? Icons.logout : Icons.login),
                          const SizedBox(width: 15),
                          Text(
                            isUserAthenticated
                                ? LocaleKeys.logout_text.tr()
                                : LocaleKeys.login_text.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
