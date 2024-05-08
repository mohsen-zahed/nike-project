class OrderModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String postalCode;
  final String address;
  final PaymentMethod paymentMethod;

  OrderModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.postalCode,
    required this.address,
    required this.paymentMethod,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        phoneNumber = json['mobile'],
        postalCode = json['postal_code'],
        address = json['address'],
        paymentMethod = PaymentMethod.cashOnDelivery;
}

enum PaymentMethod { online, cashOnDelivery }
