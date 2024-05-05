part of 'cart_data_fetch_bloc.dart';

sealed class CartDataFetchEvent extends Equatable {
  const CartDataFetchEvent();

  @override
  List<Object> get props => [];
}

final class CartDataFetchStarted extends CartDataFetchEvent {
  final AuthInfoModel? authInfoModel;

  const CartDataFetchStarted({required this.authInfoModel});
}

//* The below event is when user has already visited the cart_screen but has logged in or out after visiting screen once...
//* this is mainly useful when user pops back from registration screen and cart_screen can notice the changes happened to
//* user's registration...
final class CartAuthInfoChanged extends CartDataFetchEvent {
  final AuthInfoModel? authInfoModel;

  const CartAuthInfoChanged({required this.authInfoModel});
}
