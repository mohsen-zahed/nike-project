import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/images_paths.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/bloc/auth_bloc.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/widgets/account_text_and_login_signup.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/widgets/custom_email_text_field.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/widgets/custom_password_text_field.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/widgets/custom_registration_button.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets/nike_image_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController =
      TextEditingController(text: "test@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "123456");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: BlocProvider<AuthBloc>(
          create: (context) {
            final bloc = AuthBloc(authRepository: authRepository);
            bloc.add(AuthStarted());
            bloc.stream.forEach((blocState) {
              if (blocState is AuthSuccess) {
                Navigator.of(context).pop();
              } else if (blocState is AuthFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(blocState.errorMessage.toString()),
                  ),
                );
              }
            });
            return bloc;
          },
          child: SizedBox(
            height: getMediaQueryHeight(context), // Adjust the height as needed
            child: Center(
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  return current is AuthLoading ||
                      current is AuthInitial ||
                      current is AuthFailed;
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //* App image...
                      NikeImageWidget(
                        imagePath: ImagesPaths.lightAppLogo,
                        height: getMediaQueryHeight(context, 0.1),
                      ),
                      SizedBox(height: kDefautlVerticalGap20),
                      //* Welcome text...
                      Text(
                        LocaleKeys.welcome_text.tr(),
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: kWhiteColor,
                                ),
                      ),
                      SizedBox(height: kDefautlTextFieldVerticalGap10),
                      //* Login or Signup texts...
                      Text(
                        state.isLoginMode
                            ? LocaleKeys.login_to_account_text.tr()
                            : LocaleKeys.signup_to_account_text.tr(),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: kWhiteColor,
                            ),
                      ),
                      const SizedBox(height: 20),
                      //* E-mail textField...
                      CustomEmailTextField(
                        controller: _emailController,
                        hintText: LocaleKeys.email_address_text.tr(),
                        labelText: LocaleKeys.email_address_text.tr(),
                      ),
                      SizedBox(height: kDefautlTextFieldVerticalGap10),
                      //* Password textField...
                      CustomPasswordTextField(
                        controller: _passwordController,
                        labelText: LocaleKeys.password_text.tr(),
                        hintText: LocaleKeys.password_text.tr(),
                      ),
                      SizedBox(height: kDefaultTextFieldBorderRadius10),
                      //* Login-Signup Elevated Button...
                      CustomRegistrationButton(
                        child: state is AuthLoading
                            ? const CupertinoActivityIndicator()
                            : Text(
                                state.isLoginMode
                                    ? LocaleKeys.login_text.tr()
                                    : LocaleKeys.signup_text.tr(),
                              ),
                        onPressed: () async {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthButtonIsClicked(
                              username: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: kDefaultTextFieldBorderRadius10 + 15),
                      //* Two texts under the Elevated Button...
                      AccountTextAndLoginSignup(
                        accountText: state.isLoginMode
                            ? LocaleKeys.dont_have_an_account.tr()
                            : LocaleKeys.already_have_an_account.tr(),
                        registerText: state.isLoginMode
                            ? LocaleKeys.signup_text.tr()
                            : LocaleKeys.login_text.tr(),
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthModeChangeIsClicked());
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
