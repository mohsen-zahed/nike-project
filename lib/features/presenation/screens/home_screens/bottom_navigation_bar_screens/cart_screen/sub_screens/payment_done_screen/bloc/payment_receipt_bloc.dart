import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/models/payment_receipt_result_model.dart';
import 'package:nike_project/features/data/repository/iorder_repository.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

part 'payment_receipt_event.dart';
part 'payment_receipt_state.dart';

class PaymentReceiptBloc
    extends Bloc<PaymentReceiptEvent, PaymentReceiptState> {
  final IOrderRepository iCartRepository;
  PaymentReceiptBloc(this.iCartRepository) : super(PaymentReceiptLoading()) {
    on<PaymentReceiptEvent>((event, emit) async {
      if (event is PaymentReceiptStarted) {
        try {
          emit(PaymentReceiptLoading());
          final result = await iCartRepository.getPaymentReceipt(event.orderId);
          emit(PaymentReceiptSuccess(paymentReceiptResultModel: result));
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(
              PaymentReceiptFailed(
                  errorMessage:
                      '${LocaleKeys.dio_error_bad_response.tr()} - اطلاعات وارده شده را چک کنید'),
            );
          } else if (e.type == DioExceptionType.connectionError) {
            emit(PaymentReceiptFailed(
              errorMessage: LocaleKeys.dio_error_connection_error.tr(),
            ));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(PaymentReceiptFailed(
              errorMessage: LocaleKeys.dio_error_connection_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(PaymentReceiptFailed(
              errorMessage: LocaleKeys.dio_error_sent_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.unknown) {
            emit(PaymentReceiptFailed(
              errorMessage: LocaleKeys.something_went_wrong.tr(),
            ));
          } else {
            emit(PaymentReceiptFailed(
              errorMessage: LocaleKeys.try_again.tr(),
            ));
          }
        }
      }
    });
  }
}
