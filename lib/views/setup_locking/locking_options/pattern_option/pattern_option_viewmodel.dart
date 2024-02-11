import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/page_view_model.dart';

class PatternOptionViewModel extends PageViewModel {
  PatternOptionViewModel(super.context);

  onEnabled() {
    router.changePage(
      "/setup-pattern",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }
}
