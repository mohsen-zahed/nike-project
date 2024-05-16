import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/config/constants/constant_variables.dart';
import 'package:nike_project/features/data/models/order_model.dart';
import 'package:nike_project/features/data/repository/iorder_repository.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/sub_screens/payment_done_screen/payment_done_screen.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/sub_screens/shipping_screen/bloc/shipping_bloc.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/sub_screens/shipping_screen/widgets/custom_text_field_widget.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/widgets/shopping_details_widget.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  final TextEditingController firstNameController = TextEditingController(text: 'امیر محسن');
  final TextEditingController lastNameController = TextEditingController(text: 'زاهد');
  final TextEditingController postalCodeController = TextEditingController(text: '۱۲۳۴۵۶۷۸۹۰');
  final TextEditingController phoneNumberController = TextEditingController(text: '۱۲۳۴۵۶۷۸۹۰۰');
  final TextEditingController clientAddressController = TextEditingController(text: 'بتنیمکشتیمکشتبسشیبنسشیتکبسینشمکبتیسش');
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode postalCodeFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode clientAddressFocusNode = FocusNode();

  StreamSubscription? streamSubscription;

  String firstNameEmptyError = '';
  String lastNameEmptyError = '';
  String postalCodeEmptyError = '';
  String phoneNumberEmptyError = '';
  String clientAddressEmptyError = '';

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    postalCodeController.dispose();
    phoneNumberController.dispose();
    clientAddressController.dispose();

    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    postalCodeFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    clientAddressFocusNode.dispose();
    streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.choosing_client_and_payment_text.tr(),
        ),
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          streamSubscription = bloc.stream.listen((state) {
            if (state is ShippingSuccess) {
              if (state.createdOrderResultModel.bankGatewayUrl.isEmpty) {
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                      builder: (context) => PaymentDoneScreen(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        postalCode: postalCodeController.text,
                        phoneNumber: phoneNumberController.text,
                        address: clientAddressController.text,
                        orderId: state.createdOrderResultModel.orderId,
                      ),
                    ));
              } else {
                Navigator.push(
                  (context),
                  MaterialPageRoute(
                    builder: (context) => BankGatewayWebviewScreen(bankGatewayUrl: state.createdOrderResultModel.bankGatewayUrl),
                  ),
                );
              }
            } else if (state is ShippingFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: constantVariables.kDefautlVerticalGap20),
              CustomTextFieldForm(
                onChanged: (firstName) {
                  setState(() {
                    firstNameController.text = firstName;
                    firstNameEmptyError = '';
                  });
                },
                errorText: firstNameEmptyError,
                textInputAction: TextInputAction.next,
                onSubmitted: (value) {
                  firstNameFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(lastNameFocusNode);
                },
                hintText: LocaleKeys.first_name_text.tr(),
                controller: firstNameController,
                focusNode: firstNameFocusNode,
              ),
              SizedBox(height: constantVariables.kDefautlVerticalGap10),
              CustomTextFieldForm(
                onChanged: (lastName) {
                  setState(() {
                    lastNameController.text = lastName;
                    lastNameEmptyError = '';
                  });
                },
                errorText: lastNameEmptyError,
                textInputAction: TextInputAction.next,
                onSubmitted: (value) {
                  lastNameFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(postalCodeFocusNode);
                },
                hintText: LocaleKeys.last_name_text.tr(),
                controller: lastNameController,
                focusNode: lastNameFocusNode,
              ),
              SizedBox(height: constantVariables.kDefautlVerticalGap10),
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
              SizedBox(height: constantVariables.kDefautlVerticalGap10),
              CustomTextFieldForm(
                textInputType: const TextInputType.numberWithOptions(),
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
              SizedBox(height: constantVariables.kDefautlVerticalGap10),
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
              SizedBox(height: constantVariables.kDefautlVerticalGap10),
              ShoppingDetailsWidget(
                totalPrice: widget.totalPrice,
                shippingCost: widget.shippingCost,
                payablePrice: widget.payablePrice,
              ),
              SizedBox(height: getMediaQueryHeight(context, 0.05)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.1)),
                child: BlocBuilder<ShippingBloc, ShippingState>(
                  builder: (context, state) {
                    return state is! ShippingLoading
                        ? Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _validateAndSubmitOrder(
                                      () {
                                        BlocProvider.of<ShippingBloc>(context).add(
                                          SubmitOrder(
                                            orderModel: OrderModel(
                                              firstName: firstNameController.text,
                                              lastName: lastNameController.text,
                                              phoneNumber: phoneNumberController.text,
                                              postalCode: postalCodeController.text,
                                              address: clientAddressController.text,
                                              paymentMethod: PaymentMethod.cashOnDelivery,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).textTheme.labelLarge!.color!,
                                        borderRadius: BorderRadius.circular(constantVariables.kDefaultTextFieldBorderRadius10),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                            color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.2),
                                          ),
                                        ]),
                                    padding: EdgeInsets.symmetric(
                                      vertical: getMediaQueryHeight(context, 0.02),
                                    ),
                                    child: Center(
                                      child: Text(
                                        LocaleKeys.pay_in_place_text.tr(),
                                        style: TextStyle(color: Theme.of(context).textTheme.titleSmall!.color!),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _validateAndSubmitOrder(
                                      () {
                                        BlocProvider.of<ShippingBloc>(context).add(
                                          SubmitOrder(
                                            orderModel: OrderModel(
                                              firstName: firstNameController.text,
                                              lastName: lastNameController.text,
                                              phoneNumber: phoneNumberController.text,
                                              postalCode: postalCodeController.text,
                                              address: clientAddressController.text,
                                              paymentMethod: PaymentMethod.online,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).textTheme.titleSmall!.color!,
                                        borderRadius: BorderRadius.circular(constantVariables.kDefaultTextFieldBorderRadius10),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                            color: Theme.of(context).textTheme.bodySmall!.color!,
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
                          )
                        : const Center(child: CupertinoActivityIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateAndSubmitOrder(Function() function) {
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        postalCodeController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        clientAddressController.text.isNotEmpty) {
      function();
    } else {
      for (var i = 0; i < 4; i++) {
        setState(() {
          if (firstNameController.text.isEmpty) {
            firstNameFocusNode.requestFocus();
            firstNameEmptyError = LocaleKeys.first_name_required_text.tr();
            return;
          }
          if (lastNameController.text.isEmpty) {
            lastNameFocusNode.requestFocus();
            lastNameEmptyError = LocaleKeys.last_name_required_text.tr();
            return;
          }
          if (postalCodeController.text.isEmpty) {
            postalCodeFocusNode.requestFocus();
            postalCodeEmptyError = LocaleKeys.posta_code_required_error_text.tr();
            return;
          }
          if (phoneNumberController.text.isEmpty) {
            phoneNumberFocusNode.requestFocus();
            phoneNumberEmptyError = LocaleKeys.phone_number_required_error_text.tr();
            return;
          }
          if (clientAddressController.text.isEmpty) {
            clientAddressFocusNode.requestFocus();
            clientAddressEmptyError = LocaleKeys.client_address_required_error_text.tr();
            return;
          }
        });
      }
    }
  }
}

class BankGatewayWebviewScreen extends StatefulWidget {
  const BankGatewayWebviewScreen({super.key, required this.bankGatewayUrl});

  final String bankGatewayUrl;

  @override
  State<BankGatewayWebviewScreen> createState() => _BankGatewayWebviewScreenState();
}

class _BankGatewayWebviewScreenState extends State<BankGatewayWebviewScreen> {
  WebViewController _webViewController = WebViewController();
  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {},
      ))
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.bankGatewayUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _webViewController,
    );
  }
}
