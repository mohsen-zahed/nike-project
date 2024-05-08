class PaymentReceiptResultModel {
  final bool purchaseSuccess;
  final int payablePrice;
  final String paymentStatus;

  PaymentReceiptResultModel.fromJson(Map<String, dynamic> json)
      : purchaseSuccess = json['purchase_success'],
        payablePrice = json['payable_price'],
        paymentStatus = json['payment_status'];
}
