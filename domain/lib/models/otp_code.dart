class OtpCode {
  String code;
  String issuer;
  String address;
  String secret;

  OtpCode(this.code, this.address, this.issuer, this.secret);

  // Convert a JSON object to a SignatureEvent instance
  factory OtpCode.fromJson(Map<String, dynamic> json) {
    return OtpCode(
      "",
      json['address'] as String? ?? "",
      json['secret'] as String,
      json['issuer'] as String? ?? "",
    );
  }

  // Build an OtpCode instance from a TOTP QR code link
  factory OtpCode.fromQrCodeLink(String qrCodeLink) {
    Uri uri = Uri.parse(qrCodeLink);

    String issuerData =
        uri.pathSegments.length > 1 ? uri.pathSegments[1] : uri.pathSegments[0];
    var data = issuerData.split(':');
    var user = data.length > 1 ? data[1] : data[0];
    var issuer = data.length > 1 ? data[0] : "";

    if (user.isEmpty) {
      user = uri.queryParameters['user'] ?? '';
    }
    if (issuer.isEmpty) {
      issuer = uri.queryParameters['issuer'] ?? '';
    }

    String secret = uri.queryParameters['secret'] ?? '';

    return OtpCode("", user, issuer, secret);
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
