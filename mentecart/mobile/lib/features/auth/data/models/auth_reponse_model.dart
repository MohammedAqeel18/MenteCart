class AuthReponseModel {
  final String token;

  AuthReponseModel({
    required this.token,
  });

  factory AuthReponseModel.from(
    Map<String, dynamic>json,
  ){
    return AuthReponseModel(
      token: json['token'],
    );
  }
}