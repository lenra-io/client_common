class ApiError {
  String message;
  String reason;

  ApiError.connexionRefusedError()
      : message = "The server is unreachable.\nPlease retry in a few minutes.",
        reason = "server_unreachable";

  ApiError.unknownError()
      : message = "An unknown error occured. Please contact the support.",
        reason = "unknown_error";

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
