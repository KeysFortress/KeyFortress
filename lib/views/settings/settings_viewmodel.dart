import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/ilocal_network_service.dart';
import 'package:shared/page_view_model.dart';

class SettingsViewModel extends PageViewModel {
  late ILocalNetworkService _localNetworkService;
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

  String _localAddress = "--";
  String get localAddress => _localAddress;

  SettingsViewModel(super.context) {
    _localNetworkService = getIt.get<ILocalNetworkService>();
  }

  ready() async {
    _localAddress = await _localNetworkService.getLocalAddress();
    notifyListeners();
  }

  onSyncPressed() {}

  onQrPressed() {
    _isQrPessed = !_isQrPessed;
    notifyListeners();
  }

  onLockOptionsPressed() {
    router.changePage(
      "/lock-options",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }
}
