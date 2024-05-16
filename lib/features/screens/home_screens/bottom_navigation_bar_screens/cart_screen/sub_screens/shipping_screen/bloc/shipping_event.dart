part of 'shipping_bloc.dart';

sealed class ShippingEvent extends Equatable {
  const ShippingEvent();

  @override
  List<Object> get props => [];
}

final class SubmitOrder extends ShippingEvent {
  final OrderModel orderModel;

  const SubmitOrder({required this.orderModel});
  @override
  List<Object> get props => [orderModel];
}
