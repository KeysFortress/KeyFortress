import 'package:shared/page_view_model.dart';

class PatternOptionViewModel extends PageViewModel {
  PatternOptionViewModel(super.context);

  onEnabled() {
    router.router.router.go("/setup-pattern");
  }
}
