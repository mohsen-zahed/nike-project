import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
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
        emit(CartDataFetchLoading());
        if (accessToken != null && accessToken.accessToken.isNotEmpty) {
          await loadCartItems(emit);
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
          await loadCartItems(emit);
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
              emit(CartDataFetchSuccess(
                  cartResponseItems: successState.cartResponseItems));
            }
          }
        } catch (e) {
          throw LocaleKeys.something_went_wrong.tr();
        }
      }
    });
  }

  Future<void> loadCartItems(Emitter<CartDataFetchState> emit) async {
    try {
      final result = await iCartRepository.getAll();
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
}
