import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/cart_screen/sub_screens/payment_done_screen/payment_done_screen.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/cart_screen/sub_screens/shipping_screen/widgets/custom_text_field_widget.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/cart_screen/widgets/shopping_details_widget.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';

class ShippingScreen extends StatefulWidget {
  final int totalPrice;
  final int shippingCost;
  final int payablePrice;
  const ShippingScreen({
    super.key,
    required this.totalPrice,
    required this.shippingCost,
    required this.payablePrice,
  });

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController nameLastNameController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController clientAddressController = TextEditingController();
  final FocusNode nameLastNameFocusNode = FocusNode();
  final FocusNode postalCodeFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode clientAddressFocusNode = FocusNode();
  String nameLastNameEmptyError = '';
  String postalCodeEmptyError = '';
  String phoneNumberEmptyError = '';
  String clientAddressEmptyError = '';
  @override
  void dispose() {
    super.dispose();
    nameLastNameController.dispose();
    postalCodeController.dispose();
    phoneNumberController.dispose();
    clientAddressController.dispose();
    nameLastNameFocusNode.dispose();
    postalCodeFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    clientAddressFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.choosing_client_and_payment_text.tr(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: kDefautlVerticalGap20),
            CustomTextFieldForm(
              onChanged: (nameLastName) {
                setState(() {
                  nameLastNameController.text = nameLastName;
                  nameLastNameEmptyError = '';
                });
              },
              errorText: nameLastNameEmptyError,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                nameLastNameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(postalCodeFocusNode);
              },
              hintText: LocaleKeys.name_and_last_name_text.tr(),
              controller: nameLastNameController,
              focusNode: nameLastNameFocusNode,
            ),
            SizedBox(height: kDefautlVerticalGap10),
            CustomTextFieldForm(
              onChanged: (postalCode) {
                setState(() {
                  postalCodeController.text = postalCode;
                  postalCodeEmptyError = '';
                });
              },
              errorText: postalCodeEmptyError,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                postalCodeFocusNode.unfocus();
                FocusScope.of(context).requestFocus(phoneNumberFocusNode);
              },
              hintText: LocaleKeys.postal_code_text.tr(),
              controller: postalCodeController,
              focusNode: postalCodeFocusNode,
            ),
            SizedBox(height: kDefautlVerticalGap10),
            CustomTextFieldForm(
              onChanged: (phoneNumber) {
                setState(() {
                  phoneNumberController.text = phoneNumber;
                  phoneNumberEmptyError = '';
                });
              },
              errorText: phoneNumberEmptyError,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                phoneNumberFocusNode.unfocus();
                FocusScope.of(context).requestFocus(clientAddressFocusNode);
              },
              hintText: LocaleKeys.phone_number_text.tr(),
              controller: phoneNumberController,
              focusNode: phoneNumberFocusNode,
            ),
            SizedBox(height: kDefautlVerticalGap10),
            CustomTextFieldForm(
              onChanged: (clientAddress) {
                setState(() {
                  clientAddressController.text = clientAddress;
                  clientAddressEmptyError = '';
                });
              },
              errorText: clientAddressEmptyError,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                clientAddressFocusNode.unfocus();
              },
              hintText: LocaleKeys.client_address_text.tr(),
              controller: clientAddressController,
              focusNode: clientAddressFocusNode,
            ),
            SizedBox(height: kDefautlVerticalGap10),
            ShoppingDetailsWidget(
              totalPrice: widget.totalPrice,
              shippingCost: widget.shippingCost,
              payablePrice: widget.payablePrice,
            ),
            SizedBox(height: getMediaQueryHeight(context, 0.05)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getMediaQueryWidth(context, 0.1)),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (nameLastNameController.text.isNotEmpty &&
                            postalCodeController.text.isNotEmpty &&
                            phoneNumberController.text.isNotEmpty &&
                            clientAddressController.text.isNotEmpty) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PaymentDoneScreen(
                                    nameLastName: nameLastNameController.text,
                                    postalCode: postalCodeController.text,
                                    phoneNumber: phoneNumberController.text,
                                    address: clientAddressController.text,
                                    payablePrice: widget.payablePrice,
                                  )));
                        } else {
                          for (var i = 0; i < 3; i++) {
                            setState(() {
                              if (nameLastNameController.text.isEmpty) {
                                nameLastNameFocusNode.requestFocus();
                                nameLastNameEmptyError = LocaleKeys
                                    .name_last_name_required_text
                                    .tr();
                                return;
                              }
                              if (postalCodeController.text.isEmpty) {
                                postalCodeFocusNode.requestFocus();
                                postalCodeEmptyError = LocaleKeys
                                    .posta_code_required_error_text
                                    .tr();
                                return;
                              }
                              if (phoneNumberController.text.isEmpty) {
                                phoneNumberFocusNode.requestFocus();
                                phoneNumberEmptyError = LocaleKeys
                                    .phone_number_required_error_text
                                    .tr();
                                return;
                              }
                              if (clientAddressController.text.isEmpty) {
                                clientAddressFocusNode.requestFocus();
                                clientAddressEmptyError = LocaleKeys
                                    .client_address_required_error_text
                                    .tr();
                                return;
                              }
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).textTheme.labelLarge!.color!,
                            borderRadius: BorderRadius.circular(
                                kDefaultTextFieldBorderRadius10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color!
                                    .withOpacity(0.2),
                              ),
                            ]),
                        padding: EdgeInsets.symmetric(
                          vertical: getMediaQueryHeight(context, 0.02),
                        ),
                        child: Center(
                          child: Text(
                            LocaleKeys.pay_in_place_text.tr(),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color!),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color!,
                            borderRadius: BorderRadius.circular(
                                kDefaultTextFieldBorderRadius10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color!,
                              ),
                            ]),
                        padding: EdgeInsets.symmetric(
                          vertical: getMediaQueryHeight(context, 0.02),
                        ),
                        child: Center(
                          child: Text(
                            LocaleKeys.online_payment_text.tr(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
