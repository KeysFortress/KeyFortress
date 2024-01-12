import 'package:domain/models/enums.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:domain/models/transition_data.dart';
import 'package:presentation/page_view_model.dart';
import 'package:presentation/components/manual_sign_box.dart/manual_sign_box.dart';

class IdentityCardViewModel extends PageViewModel {
  StoredIdentity identity;

  IdentityCardViewModel(super.context, this.identity);

  onConnectPressed() {
    router.changePage(
      "/start-auth",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
      bindingData: identity,
    );
  }

  onSave() {
    router.dismissBar();
  }

  onManualSignPressed() {
    router.openBar(
      ManualSignBox(identity: identity, onSave: onSave),
      pageContext,
    );
  }

  viewHistory() {
    router.changePage(
      "/identity-history",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
      bindingData: identity,
    );
  }
}
