import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/models/cart_response_model.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

part 'cart_data_fetch_event.dart';
part 'cart_data_fetch_state.dart';

class CartDataFetchBloc extends Bloc<CartDataFetchEvent, CartDataFetchState> {
  final ICartRepository iCartRepository;
  CartDataFetchBloc(this.iCartRepository) : super(CartDataFetchLoading()) {
    on<CartDataFetchEvent>((event, emit) async {
      if (event is CartDataFetchStarted) {
        emit(CartDataFetchLoading());
        try {
          final result = await iCartRepository.getAll();
          emit(CartDataFetchSuccess(cartResponseItems: result));
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
    });
  }
}
