part of 'create_order_bloc.dart';

sealed class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();

  @override
  List<Object> get props => [];
}

final class CreateOrder extends CreateOrderEvent {
  final OrderModel orderModel;

  const CreateOrder({required this.orderModel});
  @override
  List<Object> get props => [orderModel];
}
