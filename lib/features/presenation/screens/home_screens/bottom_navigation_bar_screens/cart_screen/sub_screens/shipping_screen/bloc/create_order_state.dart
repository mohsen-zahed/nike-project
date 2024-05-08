part of 'create_order_bloc.dart';

sealed class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

final class CreateOrderInitial extends CreateOrderState {}

final class CreateOrderLoading extends CreateOrderState {}

final class CreateOrderSuccess extends CreateOrderState {
  final CreatedOrderResultModel createdOrderResultModel;

  const CreateOrderSuccess({required this.createdOrderResultModel});
  @override
  List<Object> get props => [createdOrderResultModel];
}

final class CreateOrderFailed extends CreateOrderState {
  final String errorMessage;

  const CreateOrderFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
