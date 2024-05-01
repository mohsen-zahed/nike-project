import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/images_paths.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets/nike_image_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: getMediaQueryHeight(context), // Adjust the height as needed
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NikeImageWidget(
                  imagePath: ImagesPaths.lightAppLogo,
                  height: getMediaQueryHeight(context, 0.1),
                ),
                SizedBox(height: kDefautlVerticalGap20),
                Text(
                  LocaleKeys.welcome_text.tr(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: kWhiteColor,
                      ),
                ),
                SizedBox(height: kDefautlTextFieldVerticalGap10),
                Text(
                  isLogin
                      ? LocaleKeys.login_to_account_text.tr()
                      : LocaleKeys.signup_to_account_text.tr(),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: kWhiteColor,
                      ),
                ),
                const SizedBox(height: 20),
                const CustomEmailTextField(),
                SizedBox(height: kDefautlTextFieldVerticalGap10),
                const CustomPasswordTextField(),
                SizedBox(height: kDefaultTextFieldBorderRadius10),
                CustomRegistrationButton(
                  buttonText: isLogin
                      ? LocaleKeys.login_text.tr()
                      : LocaleKeys.signup_text.tr(),
                  onPressed: () {},
                ),
                SizedBox(height: kDefaultTextFieldBorderRadius10 + 15),
                AccountTextAndLoginSignup(
                  accountText: isLogin
                      ? LocaleKeys.dont_have_an_account.tr()
                      : LocaleKeys.already_have_an_account.tr(),
                  registerText: isLogin
                      ? LocaleKeys.signup_text.tr()
                      : LocaleKeys.login_text.tr(),
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRegistrationButton extends StatelessWidget {
  const CustomRegistrationButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      margin: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(kDefaultTextFieldBorderRadius10),
          ),
          backgroundColor: kWhiteColor,
          foregroundColor: kPrimaryTextColor,
        ),
        child: Text(
          buttonText,
        ),
      ),
    );
  }
}

class AccountTextAndLoginSignup extends StatelessWidget {
  final String accountText;
  final String registerText;
  final VoidCallback onTap;
  const AccountTextAndLoginSignup({
    super.key,
    required this.accountText,
    required this.registerText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            accountText,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kCaptionsTextColor,
                ),
          ),
          SizedBox(
            width: getMediaQueryWidth(context, kDefaultPaddingWidth20),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              registerText,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor:
                        Theme.of(context).textTheme.titleSmall!.color,
                    decorationThickness: 3,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomEmailTextField extends StatelessWidget {
  const CustomEmailTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
      ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: kCaptionsTextColor),
        decoration: InputDecoration(
          label: Text(
            LocaleKeys.email_address_text.tr(),
          ),
          hintText: LocaleKeys.email_address_text.tr(),
        ),
      ),
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    super.key,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool isObsecured = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
      ),
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: kCaptionsTextColor),
        obscureText: isObsecured,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObsecured = !isObsecured;
              });
            },
            child: Icon(
              isObsecured ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          label: Text(
            LocaleKeys.password_text.tr(),
          ),
          hintText: LocaleKeys.password_text.tr(),
        ),
      ),
    );
  }
}
