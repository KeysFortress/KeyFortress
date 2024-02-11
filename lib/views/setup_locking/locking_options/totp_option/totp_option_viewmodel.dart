import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/page_view_model.dart';

class TotpOptionViewModel extends PageViewModel {
  TotpOptionViewModel(super.context);

  onToTpEnabled() {
    router.changePage(
      "/setup-totp-lock",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }
}
