import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

part 'product_add_to_cart_event.dart';
part 'product_add_to_cart_state.dart';

class ProductAddToCartBloc
    extends Bloc<ProductAddToCartEvent, ProductAddToCartState> {
  final ICartRepository iCartRepository;
  ProductAddToCartBloc({required this.iCartRepository})
      : super(ProductAddToCartInitial()) {
    on<ProductAddToCartEvent>((event, emit) async {
      if (event is CartAddToCartButtonIsClicked) {
        try {
          emit(ProductAddToCartLoading());

          final result = await iCartRepository.add(event.productId);
          emit(ProductAddToCartSuccess());
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            print(e.message);
            emit(
              ProductAddToCartFailed(
                  errorMessage: LocaleKeys.dio_error_bad_response.tr()),
            );
          } else if (e.type == DioExceptionType.connectionError) {
            emit(ProductAddToCartFailed(
              errorMessage: LocaleKeys.dio_error_connection_error.tr(),
            ));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(ProductAddToCartFailed(
              errorMessage: LocaleKeys.dio_error_connection_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(ProductAddToCartFailed(
              errorMessage: LocaleKeys.dio_error_sent_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.unknown) {
            emit(ProductAddToCartFailed(
              errorMessage: LocaleKeys.something_went_wrong.tr(),
            ));
          } else {
            emit(ProductAddToCartFailed(
              errorMessage: LocaleKeys.try_again.tr(),
            ));
          }
        }
      }
    });
  }
}
