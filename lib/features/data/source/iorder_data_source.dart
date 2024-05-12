import 'package:dio/dio.dart';
import 'package:nike_project/features/data/models/created_order_result_model.dart';
import 'package:nike_project/features/data/models/order_model.dart';
import 'package:nike_project/features/data/models/payment_receipt_result_model.dart';

abstract class IOrderDataSource {
  Future<CreatedOrderResultModel> createOrder(OrderModel order);
  Future<PaymentReceiptResultModel> getPaymentReceipt(int orderId);
  Future<List<OrderHistoryModel>> getAllOrders();
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

  @override
  Future<PaymentReceiptResultModel> getPaymentReceipt(int orderId) async {
    final response = await httpClient.get('order/checkout?order_id=$orderId');
    return PaymentReceiptResultModel.fromJson(response.data);
  }

  @override
  Future<List<OrderHistoryModel>> getAllOrders() async {
    final response = await httpClient.get('order/list');
    print('data: ${response.data}');
    if (response.data is List) {
      return (response.data as List)
          .map((e) => OrderHistoryModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Response data is not a list');
    }
  }
}
