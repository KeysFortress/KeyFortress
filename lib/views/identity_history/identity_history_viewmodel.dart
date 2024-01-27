import 'package:domain/models/signature_event.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:infrastructure/interfaces/isignature_store.dart';
import 'package:shared/page_view_model.dart';

class IdentityHistoryViewModel extends PageViewModel {
  late ISignatureStore _signatureStore;
  late StoredIdentity _identity;
  StoredIdentity get identity => _identity;
  List<SignatureEvent> _events = [];
  List<SignatureEvent> get events => _events;

  IdentityHistoryViewModel(super.context) {
    _identity = router.getPageBindingData() as StoredIdentity;
    _signatureStore = getIt.get<ISignatureStore>();
  }

  ready() async {
    _events = await _signatureStore.get();
    notifyListeners();
  }
}
