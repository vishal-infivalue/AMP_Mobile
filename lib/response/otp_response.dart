class OTPResponse {
  final String message;

  OTPResponse({required this.message});

  // Factory method to create an instance from JSON
  factory OTPResponse.fromJson(Map<String, dynamic> json) {
    return OTPResponse(
      message: json['message'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
