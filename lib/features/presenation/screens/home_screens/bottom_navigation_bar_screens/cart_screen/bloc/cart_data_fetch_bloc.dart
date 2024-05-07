import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/models/auth_info_model.dart';
import 'package:nike_project/features/data/models/cart_response_model.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

part 'cart_data_fetch_event.dart';
part 'cart_data_fetch_state.dart';

class CartDataFetchBloc extends Bloc<CartDataFetchEvent, CartDataFetchState> {
  final ICartRepository iCartRepository;
  CartDataFetchBloc(this.iCartRepository) : super(CartDataFetchLoading()) {
    on<CartDataFetchEvent>((event, emit) async {
      //* This block of 'if statement' is when user has just opened the app, in another word is when user has not
      //* interacted with cart_screen yet...
      if (event is CartDataFetchStarted) {
        final accessToken = AuthRepositoryImpl.authChangeNotifier.value;
        if (accessToken != null && accessToken.accessToken.isNotEmpty) {
          await loadCartItems(emit, true);
        } else {
          emit(CartAuthRequested());
        }

        //* But this block is for when user has opened the app and already interacted with cart_screen and after interacting
        //* this screen once, they login or logout then...
        //* before reaching this line, the function within the initState in cart_screen listens to any changes to authInfoModel
        //* and invokes the function if there is any changes...
      } else if (event is CartAuthInfoChanged) {
        //* Because there is a possibility of logging in or loggin out, we must check both of conditions...
        //* first condition when user logs out...
        if (event.authInfoModel == null ||
            event.authInfoModel!.accessToken.isEmpty) {
          emit(CartAuthRequested());
          //* second condition when user logs back in...
        } else {
          await loadCartItems(emit, false);
        }
      } else if (event is CartRemoveButtonIsClicked) {
        try {
          if (state is CartDataFetchSuccess) {
            final successState = (state as CartDataFetchSuccess);
            final index = successState.cartResponseItems.cartItems.indexWhere(
                (element) => element.cartItemId == event.removingItemId);
            successState
                .cartResponseItems.cartItems[index].deleteButtonLoading = true;
            emit(CartDataFetchSuccess(
                cartResponseItems: successState.cartResponseItems));
          }
          await Future.delayed(const Duration(seconds: 2));
          await cartRepository.delete(event.removingItemId);
          if (state is CartDataFetchSuccess) {
            final successState = (state as CartDataFetchSuccess);
            successState.cartResponseItems.cartItems.removeWhere(
              (element) => element.cartItemId == event.removingItemId,
            );

            if (successState.cartResponseItems.cartItems.isEmpty) {
              emit(CartEmptyData());
            } else {
              emit(calculateShoppingDetails(successState.cartResponseItems));
            }
          }
        } catch (e) {
          throw LocaleKeys.something_went_wrong.tr();
        }
      } else if (event is IncreaseButtonIsClicked ||
          event is DecreaseButtonIsClicked) {
        try {
          if (state is CartDataFetchSuccess) {
            final successState = (state as CartDataFetchSuccess);
            int cartItemId = 0;
            if (event is IncreaseButtonIsClicked) {
              cartItemId = event.cartItemId;
            } else if (event is DecreaseButtonIsClicked) {
              cartItemId = event.cartItemId;
            }
            //* Here we specify the index of cartItem that has been pressed by user...
            final index = successState.cartResponseItems.cartItems
                .indexWhere((element) => element.cartItemId == cartItemId);
            successState.cartResponseItems.cartItems[index].countLoading = true;
            //* Updating the state to show user a loading widget on UI...
            emit(CartDataFetchSuccess(
                cartResponseItems: successState.cartResponseItems));
            //* Increasing or Deacreasing the count value according to event...
            //* The count value is changed first and then the new value will be sent to server...
            final newCount = event is IncreaseButtonIsClicked
                ? ++successState.cartResponseItems.cartItems[index].count
                : --successState.cartResponseItems.cartItems[index].count;
            await cartRepository.changeCount(cartItemId, newCount);
            //* After coming the response back, we check our list for coming updates...
            //* The first index that we reach in our list is the item that its count should update...
            successState.cartResponseItems.cartItems
                .firstWhere((element) => element.cartItemId == cartItemId)
              ..count = newCount
              ..countLoading = false;
            //* Finaly updating UI to latest updates...
            emit(CartDataFetchSuccess(
                cartResponseItems: successState.cartResponseItems));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    });
  }

  Future<void> loadCartItems(
      Emitter<CartDataFetchState> emit, bool isRefreshing) async {
    try {
      final result = await iCartRepository.getAll();
      if (!isRefreshing) {
        emit(CartDataFetchLoading());
      }
      if (result.cartItems.isEmpty) {
        emit(CartEmptyData());
      } else {
        emit(CartDataFetchSuccess(cartResponseItems: result));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        emit(
          CartDataFetchFailed(
              errorMessage: LocaleKeys.dio_error_bad_response.tr()),
        );
      } else if (e.type == DioExceptionType.connectionError) {
        emit(CartDataFetchFailed(
          errorMessage: LocaleKeys.dio_error_connection_error.tr(),
        ));
      } else if (e.type == DioExceptionType.connectionTimeout) {
        emit(CartDataFetchFailed(
          errorMessage: LocaleKeys.dio_error_connection_timeout.tr(),
        ));
      } else if (e.type == DioExceptionType.sendTimeout) {
        emit(CartDataFetchFailed(
          errorMessage: LocaleKeys.dio_error_sent_timeout.tr(),
        ));
      } else if (e.type == DioExceptionType.unknown) {
        emit(CartDataFetchFailed(
          errorMessage: LocaleKeys.something_went_wrong.tr(),
        ));
      } else {
        emit(CartDataFetchFailed(
          errorMessage: LocaleKeys.try_again.tr(),
        ));
      }
    }
  }

  CartDataFetchSuccess calculateShoppingDetails(
      CartResponseModel cartResponseModel) {
    int totalPrice = 0;
    int shippingCost = 0;
    int payablePrice = 0;
    cartResponseModel.cartItems.forEach((cartItem) {
      totalPrice += cartItem.product.previousPrice * cartItem.count;
      payablePrice += cartItem.product.price * cartItem.count;
    });
    shippingCost = payablePrice >= 300 ? 0 : 5000;
    cartResponseModel.totalPrice = totalPrice;
    cartResponseModel.shippingCost = shippingCost;
    cartResponseModel.payablePrice = payablePrice;
    return CartDataFetchSuccess(cartResponseItems: cartResponseModel);
  }
}
