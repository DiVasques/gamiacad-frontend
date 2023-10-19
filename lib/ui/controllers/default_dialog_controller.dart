import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

class DefaultDialogController extends BaseController {
  final Future<String?> actionMethod;

  DefaultDialogController({required this.actionMethod});

  Future<bool> takeAction() async {
    setState(ViewState.busy);
    String? errorMessage = await actionMethod;
    if (errorMessage == null) {
      return true;
    }
    setErrorMessage(errorMessage);
    setState(ViewState.error);
    return false;
  }
}
