part of 'order_history_bloc.dart';

sealed class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

final class OrderHistoryLoading extends OrderHistoryState {}

final class OrderHistorySuccess extends OrderHistoryState {
  final List<OrderHistoryModel> orders;

  const OrderHistorySuccess({required this.orders});
  @override
  List<Object> get props => [orders];
}

final class OrderHistoryFailed extends OrderHistoryState {
  final String errorMessage;

  const OrderHistoryFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
