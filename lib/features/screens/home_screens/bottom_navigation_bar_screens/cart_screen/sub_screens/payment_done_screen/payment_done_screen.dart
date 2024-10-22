import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/config/constants/colors.dart';
import 'package:nike_project/config/constants/constant_variables.dart';
import 'package:nike_project/features/data/repository/iorder_repository.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/sub_screens/payment_done_screen/bloc/payment_receipt_bloc.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/sub_screens/payment_done_screen/widgets/two_texts_widgets_horizontally.dart';
import 'package:nike_project/utils/theme_checker.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/currency_unit_extension.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/sub_screens/payment_done_screen/widgets/back_to_home_button.dart';
import 'package:nike_project/widgets_common_in_all_screens/default_failed_widget.dart';

class PaymentDoneScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String postalCode;
  final String phoneNumber;
  final String address;
  final int orderId;
  const PaymentDoneScreen({
    super.key,
    required this.firstName,
    required this.postalCode,
    required this.phoneNumber,
    required this.address,
    required this.lastName,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.payment_bill_text.tr()),
      ),
      body: BlocProvider<PaymentReceiptBloc>(
        create: (context) => PaymentReceiptBloc(orderRepository)..add(PaymentReceiptStarted(orderId: orderId)),
        child: BlocBuilder<PaymentReceiptBloc, PaymentReceiptState>(builder: (context, state) {
          if (state is PaymentReceiptSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getMediaQueryWidth(context, constantVariables.kDefaultBorderRadius20),
                        vertical: getMediaQueryHeight(context, 0.02)),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kGreyColorShade300,
                      ),
                      borderRadius: BorderRadius.circular(constantVariables.kDefaultTextFieldBorderRadius10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: getMediaQueryHeight(context, 0.025)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, constantVariables.kDefaultBorderRadius20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.paymentReceiptResultModel.purchaseSuccess
                                ? LocaleKeys.payment_was_made_successfully_text.tr()
                                : LocaleKeys.payment_was_not_successful_text.tr(),
                            style: themeChecker.isCurrentThemeLight(context)
                                ? Theme.of(context).textTheme.bodyLarge!.copyWith(color: kSecondaryColor)
                                : Theme.of(context).textTheme.bodyLarge!.copyWith(color: kWhiteColor),
                          ),
                          SizedBox(height: getMediaQueryHeight(context, 0.03)),
                          TwoTextsWidgetsHorizontally(title: LocaleKeys.order_status_text.tr(), value: state.paymentReceiptResultModel.paymentStatus),
                          Divider(height: getMediaQueryHeight(context, 0.04)),
                          TwoTextsWidgetsHorizontally(
                              title: LocaleKeys.sum_text.tr(), value: state.paymentReceiptResultModel.payablePrice.withPriceLabel),
                          SizedBox(height: getMediaQueryHeight(context, 0.03)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.client_information_text.tr(),
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kCaptionsTextColor),
                              ),
                              SizedBox(height: getMediaQueryHeight(context, 0.01)),
                              TwoTextsWidgetsHorizontally(title: LocaleKeys.first_name_text.tr(), value: firstName),
                              SizedBox(height: getMediaQueryHeight(context, 0.01)),
                              TwoTextsWidgetsHorizontally(title: LocaleKeys.last_name_text.tr(), value: lastName),
                              SizedBox(height: getMediaQueryHeight(context, 0.01)),
                              TwoTextsWidgetsHorizontally(title: LocaleKeys.postal_code_text.tr(), value: postalCode),
                              SizedBox(height: getMediaQueryHeight(context, 0.01)),
                              TwoTextsWidgetsHorizontally(title: LocaleKeys.phone_number_text.tr(), value: phoneNumber),
                              SizedBox(height: getMediaQueryHeight(context, 0.01)),
                              TwoTextsWidgetsHorizontally(title: LocaleKeys.client_address_text.tr(), value: address),
                              SizedBox(height: getMediaQueryHeight(context, 0.01)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  BackToHomeButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(LocaleKeys.back_to_home.tr()),
                  ),
                ],
              ),
            );
          } else if (state is PaymentReceiptLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const DefaultFailedWidget();
          }
        }),
      ),
    );
  }
}
