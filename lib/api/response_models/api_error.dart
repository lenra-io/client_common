class ApiError {
  String message;
  String reason;

  ApiError.connexionRefusedError()
      : message = "The server is unreachable.\nPlease retry in a few minutes.",
        reason = "server_unreachable";

  ApiError.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        reason = json["reason"];

  Map<String, dynamic> toJson() => {
        'message': message,
        'reason': reason,
      };

  @override
  String toString() {
    return message;
  }
}
