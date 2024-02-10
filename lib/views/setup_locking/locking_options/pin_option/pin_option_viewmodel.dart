import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/page_view_model.dart';

class PinOptionViewModel extends PageViewModel {
  PinOptionViewModel(super.context);

  onEnabled() {
    router.changePage(
      "/setup-pin",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }
}
