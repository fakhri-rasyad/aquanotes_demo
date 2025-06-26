class LoginResponseModel {
  final String accessToken;
  final String tokenType;

  LoginResponseModel(this.accessToken, this.tokenType);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        json["access_token"] as String, json["token_type"] as String);
  }
}
