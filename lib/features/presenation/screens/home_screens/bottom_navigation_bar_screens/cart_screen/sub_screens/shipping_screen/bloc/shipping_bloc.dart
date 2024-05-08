import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/models/created_order_result_model.dart';
import 'package:nike_project/features/data/models/order_model.dart';
import 'package:nike_project/features/data/repository/iorder_repository.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final IOrderRepository iOrderRepository;
  ShippingBloc(this.iOrderRepository) : super(ShippingInitial()) {
    on<ShippingEvent>((event, emit) async {
      if (event is SubmitOrder) {
        try {
          emit(ShippingLoading());
          final result = await iOrderRepository.createOrder(event.orderModel);
          emit(ShippingSuccess(createdOrderResultModel: result));
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(
              ShippingFailed(
                  errorMessage:
                      '${LocaleKeys.dio_error_bad_response.tr()} - اطلاعات وارده شده را چک کنید'),
            );
          } else if (e.type == DioExceptionType.connectionError) {
            emit(ShippingFailed(
              errorMessage: LocaleKeys.dio_error_connection_error.tr(),
            ));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(ShippingFailed(
              errorMessage: LocaleKeys.dio_error_connection_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(ShippingFailed(
              errorMessage: LocaleKeys.dio_error_sent_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.unknown) {
            emit(ShippingFailed(
              errorMessage: LocaleKeys.something_went_wrong.tr(),
            ));
          } else {
            emit(ShippingFailed(
              errorMessage: LocaleKeys.try_again.tr(),
            ));
          }
        }
      }
    });
  }
}
