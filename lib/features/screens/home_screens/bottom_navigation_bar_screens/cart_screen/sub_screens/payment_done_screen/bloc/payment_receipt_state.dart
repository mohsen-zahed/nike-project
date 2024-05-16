part of 'payment_receipt_bloc.dart';

sealed class PaymentReceiptState extends Equatable {
  const PaymentReceiptState();

  @override
  List<Object> get props => [];
}

final class PaymentReceiptLoading extends PaymentReceiptState {}

final class PaymentReceiptSuccess extends PaymentReceiptState {
  final PaymentReceiptResultModel paymentReceiptResultModel;

  const PaymentReceiptSuccess({required this.paymentReceiptResultModel});
  @override
  List<Object> get props => [paymentReceiptResultModel];
}

final class PaymentReceiptFailed extends PaymentReceiptState {
  final String errorMessage;

  const PaymentReceiptFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
