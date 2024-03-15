import 'package:shared/page_view_model.dart';

class SettingsViewModel extends PageViewModel {
  bool _isQrPessed = false;
  bool get isQrPressed => _isQrPessed;
  String getConnectionString = """
{
  publicKey: {
    challenge: new Uint8Array([117, 61, 252, 231, 191, 241, ...]),
    rp: { id: "acme.com", name: "ACME Corporation" },
    user: {
      id: new Uint8Array([79, 252, 83, 72, 214, 7, 89, 26]),
      name: "jamiedoe",
      displayName: "Jamie Doe"
    },
    pubKeyCredParams: [ {type: "public-key", alg: -7} ]
  }
}
""";

  SettingsViewModel(super.context);

  onSyncPressed() {}

  onQrPressed() {
    _isQrPessed = !_isQrPessed;
    notifyListeners();
  }
}
