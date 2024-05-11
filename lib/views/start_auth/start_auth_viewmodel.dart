import 'dart:convert';
import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:domain/models/qr_code_data.dart';
import 'package:shared/page_view_model.dart';
import 'package:domain/models/http_request.dart';

class StartAuthViewModel extends PageViewModel {
  late IHttpProviderService _provider;
  late StoredIdentity _identity;
  late ISignatureService _signatureService;
  bool scanned = false;

  StartAuthViewModel(super.context) {
    _provider = getIt.get<IHttpProviderService>();
    _signatureService = getIt.get<ISignatureService>();
    _identity = router.getPageBindingData() as StoredIdentity;
  }

  onScanComplete(String result) async {
    if (scanned) return;

    try {
      scanned = true;
      var jsonData = jsonDecode(result);
      var qrData = QrCodeData.fromJson(jsonData);
      var importIdentity = await _signatureService.importKeyPair(
        _identity.publicKey,
        _identity.privateKey,
      );

      var signature =
          await _signatureService.signMessage(importIdentity, qrData.challenge);

      var sendSignature = await _provider.postRequest(
        HttpRequest(
          qrData.finishChallenge,
          {},
          jsonEncode(
            {
              'Uuid': qrData.forUser,
              'Signature': base64.encode(signature.bytes),
            },
          ),
        ),
      );

      if (sendSignature == null || sendSignature.statusCode != 200)
        throw BaseException(
          context: pageContext,
          message:
              "Failed to deliver a signature, response code ${sendSignature?.statusCode}",
        );

      router.backToPrevious(pageContext);
    } catch (ex) {
      scanned = false;
      router.backToPrevious(pageContext);

      throw BaseException(
        context: pageContext,
        message: "Failed to deliver a signature, response code 500",
      );
    }
  }
}
