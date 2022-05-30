class ApiError {
  String message;
  int code;

  ApiError.connexionRefusedError()
      : message = "The server is unreachable.\nPlease retry in a few minutes.",
        code = -1;

  ApiError.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        code = json["code"];

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
      };

  bool is401() {
    return code == 401;
  }

  @override
  String toString() {
    return "$message (code $code)";
  }
}
