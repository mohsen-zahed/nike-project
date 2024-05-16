import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/models/order_model.dart';
import 'package:nike_project/features/data/repository/iorder_repository.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final IOrderRepository iOrderRepository;
  OrderHistoryBloc(this.iOrderRepository) : super(OrderHistoryLoading()) {
    on<OrderHistoryEvent>((event, emit) async {
      if (event is OrderHistoryStarted) {
        try {
          emit(OrderHistoryLoading());
          final result = await iOrderRepository.getAllOrders();
          emit(OrderHistorySuccess(orders: result));
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(
              OrderHistoryFailed(
                  errorMessage: LocaleKeys.dio_error_bad_response.tr()),
            );
          } else if (e.type == DioExceptionType.connectionError) {
            emit(OrderHistoryFailed(
              errorMessage: LocaleKeys.dio_error_connection_error.tr(),
            ));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(OrderHistoryFailed(
              errorMessage: LocaleKeys.dio_error_connection_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(OrderHistoryFailed(
              errorMessage: LocaleKeys.dio_error_sent_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.unknown) {
            emit(OrderHistoryFailed(
              errorMessage: LocaleKeys.something_went_wrong.tr(),
            ));
          } else {
            emit(OrderHistoryFailed(
              errorMessage: LocaleKeys.try_again.tr(),
            ));
          }
        }
      }
    });
  }
}
