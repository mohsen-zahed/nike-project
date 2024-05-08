import 'package:nike_project/features/data/models/created_order_result_model.dart';
import 'package:nike_project/features/data/models/order_model.dart';
import 'package:nike_project/features/data/source/iorder_data_source.dart';
import 'package:nike_project/packages/dio/dio_package.dart';

final orderRepository = OrderRepositoryImp(
    iOrderDataSource: OrderDataSourceImp(httpClient: httpClient));

abstract class IOrderRepository {
  Future<CreatedOrderResultModel> createOrder(OrderModel order);
}

class OrderRepositoryImp implements IOrderRepository {
  final IOrderDataSource iOrderDataSource;

  OrderRepositoryImp({required this.iOrderDataSource});
  @override
  Future<CreatedOrderResultModel> createOrder(OrderModel order) =>
      iOrderDataSource.createOrder(order);
}
