class AuthInfoModel {
  final String accessToken;
  final String refreshToken;
  final String email;

  AuthInfoModel({
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });
}
