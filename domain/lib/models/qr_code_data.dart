class QrCodeData {
  String initial;
  String finishChallenge;
  String forUser;
  String? bearer;

  QrCodeData(
    this.initial,
    this.finishChallenge,
    this.forUser,
    this.bearer,
  );

  factory QrCodeData.fromJson(Map<String, dynamic> json) {
    return QrCodeData(
      json['Initial'] as String,
      json['FinishChallenge'] as String,
      json['ForUser'] as String,
      json['bearer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Initial': initial,
      'FinishChallenge': finishChallenge,
      'ForUser': forUser,
      'bearer': bearer,
    };
  }
}
