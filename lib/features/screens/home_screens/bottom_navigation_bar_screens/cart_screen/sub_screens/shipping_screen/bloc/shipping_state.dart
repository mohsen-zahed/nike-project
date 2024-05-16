part of 'shipping_bloc.dart';

sealed class ShippingState extends Equatable {
  const ShippingState();

  @override
  List<Object> get props => [];
}

final class ShippingInitial extends ShippingState {}

final class ShippingLoading extends ShippingState {}

final class ShippingSuccess extends ShippingState {
  final CreatedOrderResultModel createdOrderResultModel;

  const ShippingSuccess({required this.createdOrderResultModel});
  @override
  List<Object> get props => [createdOrderResultModel];
}

final class ShippingFailed extends ShippingState {
  final String errorMessage;

  const ShippingFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
