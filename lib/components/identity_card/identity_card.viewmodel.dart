import 'package:domain/models/stored_identity.dart';
import 'package:presentation/page_view_model.dart';
import 'package:presentation/components/manual_sign_box.dart/manual_sign_box.dart';

class IdentityCardViewModel extends PageViewModel {
  StoredIdentity identity;
  IdentityCardViewModel(super.context, this.identity);

  onConnectPressed() {
    router.openBar(
      ManualSignBox(identity: identity, onSave: onSave),
      pageContext,
    );
  }

  onSave() {
    router.dismissBar();
  }
}
