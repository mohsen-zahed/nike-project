import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/config/constants/products_sort_cons.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

part 'products_list_event.dart';
part 'products_list_state.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  final IProductsRepository productsRepository;
  ProductsListBloc(this.productsRepository) : super(ProductsListLoading()) {
    on<ProductsListEvent>((event, emit) async {
      if (event is ProductsListStarted) {
        try {
          emit(ProductsListLoading());
          final result = await productsRepository.getAllProducts(event.sort);
          emit(
            ProductsListSuccess(
              products: result,
              sort: event.sort,
              sortNames: ProductsSortCons.sortTypes,
            ),
          );
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(
              ProductsListFailed(
                  errorMessage: LocaleKeys.dio_error_bad_response.tr()),
            );
          } else if (e.type == DioExceptionType.connectionError) {
            emit(ProductsListFailed(
              errorMessage: LocaleKeys.dio_error_connection_error.tr(),
            ));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(ProductsListFailed(
              errorMessage: LocaleKeys.dio_error_connection_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(ProductsListFailed(
              errorMessage: LocaleKeys.dio_error_sent_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.unknown) {
            emit(ProductsListFailed(
              errorMessage: LocaleKeys.something_went_wrong.tr(),
            ));
          } else {
            emit(ProductsListFailed(
              errorMessage: LocaleKeys.try_again.tr(),
            ));
          }
        }
      }
    });
  }
}
