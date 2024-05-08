class CreatedOrderResultModel {
  final int orderId;
  final String bankGatewayUrl;

  CreatedOrderResultModel.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        bankGatewayUrl = json['bank_gateway_url'];
}
