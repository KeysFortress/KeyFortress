import 'dart:convert';
import 'package:domain/converters/binary_converter.dart';
import 'package:domain/models/http_request.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:presentation/page_view_model.dart';
import 'package:domain/models/qr_code_data.dart';

class StartAuthViewModel extends PageViewModel {
  late IHttpProviderService _provider;
  late StoredIdentity _identity;
  late ISignatureService _signatureService;

  StartAuthViewModel(super.context) {
    _provider = getIt.get<IHttpProviderService>();
    _signatureService = getIt.get<ISignatureService>();
    _identity = router.getPageBindingData() as StoredIdentity;
  }

  onScanComplete(String result) async {
    try {
      var jsonData = jsonDecode(result);
      var qrData = QrCodeData.fromJson(jsonData);
      var importIdentity = await _signatureService.importKeyPair(
        _identity.publicKey,
        _identity.privateKey,
      );

      var signature = await _signatureService.signMessage(
        importIdentity,
        qrData.message,
      );

      Map<String, String> headers = qrData.bearer.isNotEmpty
          ? {"Authorized": "Bearer ${qrData.bearer}"}
          : {};
      var httpResult = await _provider.postRequest(
        HttpRequest(
          qrData.url,
          headers,
          jsonEncode(
            {
              "signature": BianaryConverter.toHex(signature.bytes),
            },
          ),
        ),
      );
      if (httpResult == null || httpResult.statusCode != 200) {
        //TODO log server error
        //TODO go to failed
      }

      //TODO go to success
    } catch (ex) {
      //TODO go to failed
    }
  }
}
