import 'package:shared/page_view_model.dart';

class TotpOptionViewModel extends PageViewModel {
  TotpOptionViewModel(super.context);

  onToTpEnabled() {
    router.router.router.go("/setup-totp-lock");
  }
}
