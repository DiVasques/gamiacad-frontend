import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/models/user.dart';
import 'package:gami_acad/repository/user_repository.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

class HomeController extends BaseController {
  final String userId;
  HomeController({required this.userId}) {
    getUser();
  }

  final UserRepository _userRepository = UserRepository();
  User get user => _userRepository.user;

  Future<void> getUser() async {
    setState(ViewState.busy);
    Result result = await _userRepository.getUser(id: userId);

    if (result.status) {
      setState(ViewState.idle);
    } else {
      setErrorMessage(result.message ?? '');
      setState(ViewState.error);
    }
  }
}
