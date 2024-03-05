import 'package:shared/page_view_model.dart';

class PinOptionViewModel extends PageViewModel {
  PinOptionViewModel(super.context);

  onEnabled() {
    router.router.router.go("/setup-pin");
  }
}
