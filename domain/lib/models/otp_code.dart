class OtpCode {
  String code;
  String issuer;
  String address;
  String secret;

  OtpCode(this.code, this.address, this.issuer, this._secret);

  // Convert a JSON object to a SignatureEvent instance
  factory OtpCode.fromJson(Map<String, dynamic> json) {
    return OtpCode(
      "",
      json['address'] as String,
      json['secret'] as String,
      json['issuer'] as String,
    );
  }

  // Build an OtpCode instance from a TOTP QR code link
  factory OtpCode.fromQrCodeLink(String qrCodeLink) {
    Uri uri = Uri.parse(qrCodeLink);

    String issuer = uri.pathSegments.first;
    String account = uri.pathSegments.length > 1 ? uri.pathSegments[1] : '';
    String secret = uri.queryParameters['secret'] ?? '';

    return OtpCode("", account, issuer, secret);
  }

  // Convert a SignatureEvent instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'secret': secret,
    };
  }

  bool matchSecret(String matching) {
    return secret == matching;
  }
}
