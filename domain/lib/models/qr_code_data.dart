class QrCodeData {
  String url;
  String message;
  String bearer;

  QrCodeData(this.url, this.message, this.bearer);

  factory QrCodeData.fromJson(Map<String, dynamic> json) {
    return QrCodeData(
      json['url'] as String,
      json['message'] as String,
      json['bearer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'message': message,
      'bearer': bearer,
    };
  }
}
