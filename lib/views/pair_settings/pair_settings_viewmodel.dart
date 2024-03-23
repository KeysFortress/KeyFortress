import 'package:basic_utils/basic_utils.dart';
import 'package:infrastructure/interfaces/icertificate_service.dart';
import 'package:infrastructure/interfaces/ilocal_network_service.dart';
import 'package:shared/page_view_model.dart';

class PairSettingsViewModel extends PageViewModel {
  late ICertificateService _certificateService;
  late ILocalNetworkService _localNetworkService;
  List<X509CertificateData>? _x509certificateData;
  List<X509CertificateData>? get certificateData => _x509certificateData;

  bool _pairEnabled = true;
  get pairEnabled => _pairEnabled;

  PairSettingsViewModel(super.context) {
    _certificateService = getIt.get<ICertificateService>();
    _localNetworkService = getIt.get<ILocalNetworkService>();
  }

  int _currentPort = 2234;
  get currentPort => _currentPort;

  read() async {
    _x509certificateData = await _certificateService.read();
    _currentPort = await _localNetworkService.getPort();
    notifyListeners();
  }

  void onEnabledChanged(bool value) {}

  onPortNumberChanged(String number) async {
    if (number.isEmpty) return;

    await _localNetworkService.setPort(number);
    _currentPort = int.parse(number);
  }

  onUpdateCertificate() {}
}
