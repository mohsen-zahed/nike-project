import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/models/created_order_result_model.dart';
import 'package:nike_project/features/data/models/order_model.dart';
import 'package:nike_project/features/data/repository/iorder_repository.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  final IOrderRepository iOrderRepository;
  CreateOrderBloc(this.iOrderRepository) : super(CreateOrderInitial()) {
    on<CreateOrderEvent>((event, emit) async {
      if (event is CreateOrder) {
        try {
          emit(CreateOrderLoading());
          final result = await iOrderRepository.createOrder(event.orderModel);
          emit(CreateOrderSuccess(createdOrderResultModel: result));
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(
              CreateOrderFailed(
                  errorMessage:
                      '${LocaleKeys.dio_error_bad_response.tr()} - اطلاعات وارده شده را چک کنید'),
            );
          } else if (e.type == DioExceptionType.connectionError) {
            emit(CreateOrderFailed(
              errorMessage: LocaleKeys.dio_error_connection_error.tr(),
            ));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(CreateOrderFailed(
              errorMessage: LocaleKeys.dio_error_connection_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(CreateOrderFailed(
              errorMessage: LocaleKeys.dio_error_sent_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.unknown) {
            emit(CreateOrderFailed(
              errorMessage: LocaleKeys.something_went_wrong.tr(),
            ));
          } else {
            emit(CreateOrderFailed(
              errorMessage: LocaleKeys.try_again.tr(),
            ));
          }
        }
      }
    });
  }
}
