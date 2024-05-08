import 'package:dio/dio.dart';
import 'package:nike_project/features/data/models/created_order_result_model.dart';
import 'package:nike_project/features/data/models/order_model.dart';

abstract class IOrderDataSource {
  Future<CreatedOrderResultModel> createOrder(OrderModel order);
}

class OrderDataSourceImp implements IOrderDataSource {
  final Dio httpClient;

  OrderDataSourceImp({required this.httpClient});
  @override
  Future<CreatedOrderResultModel> createOrder(OrderModel order) async {
    final response = await httpClient.post('order/submit', data: {
      'first_name': order.firstName,
      'last_name': order.lastName,
      'postal_code': order.postalCode,
      'mobile': order.phoneNumber,
      'address': order.address,
      'payment_method': order.paymentMethod == PaymentMethod.online
          ? 'online'
          : 'cash_on_delivery',
    });
    return CreatedOrderResultModel.fromJson(response.data);
  }
}
