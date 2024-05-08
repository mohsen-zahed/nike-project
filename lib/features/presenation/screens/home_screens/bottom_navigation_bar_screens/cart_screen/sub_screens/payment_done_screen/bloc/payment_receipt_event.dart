part of 'payment_receipt_bloc.dart';

sealed class PaymentReceiptEvent extends Equatable {
  const PaymentReceiptEvent();

  @override
  List<Object> get props => [];
}

final class PaymentReceiptStarted extends PaymentReceiptEvent {
  final int orderId;

  const PaymentReceiptStarted({required this.orderId});
  @override
  List<Object> get props => [orderId];
}
