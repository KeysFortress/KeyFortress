class SignatureEvent {
  String publicKey;
  String signature;
  String message;
  String data;

  SignatureEvent(this.publicKey, this.signature, this.message, this.data);

  // Convert a JSON object to a SignatureEvent instance
  factory SignatureEvent.fromJson(Map<String, dynamic> json) {
    return SignatureEvent(
      json['publicKey'] as String,
      json['signature'] as String,
      json['message'] as String,
      json['data'] as String,
    );
  }

  // Convert a SignatureEvent instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'publicKey': publicKey,
      'signature': signature,
      'message': message,
      'data': data,
    };
  }
}
