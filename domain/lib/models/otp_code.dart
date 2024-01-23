class OtpCode {
  String code;
  String address;
  String _secret;

  OtpCode(this.code, this.address, this._secret);

  // Convert a JSON object to a SignatureEvent instance
  factory OtpCode.fromJson(Map<String, dynamic> json) {
    return OtpCode(
      "",
      json['address'] as String,
      json['secret'] as String,
    );
  }

  // Convert a SignatureEvent instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'secret': _secret,
    };
  }

  bool matchSecret(String secret) {
    return _secret == secret;
  }
}
