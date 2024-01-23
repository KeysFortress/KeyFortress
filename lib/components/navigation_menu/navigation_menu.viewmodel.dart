import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:presentation/page_view_model.dart';

class NavigationMenuViewModel extends PageViewModel {
  NavigationMenuViewModel(super.context);

  ActiveNavigationPage _selected = ActiveNavigationPage.passwords;
  ActiveNavigationPage get selected => _selected;

  onPasswordsPressed() {
    _selected = ActiveNavigationPage.passwords;
    notifyListeners();
  }

  onCertificatesPressed() {
    _selected = ActiveNavigationPage.identities;
    notifyListeners();
  }

  onTotpPressed() {
    router.changePage(
      "/totp",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }
}
