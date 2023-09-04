import 'package:gami_acad/repository/auth_repository.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/models/user.dart';
import 'package:gami_acad/repository/user_repository.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

class HomeController extends BaseController {
  late String userId;
  late UserRepository _userRepository;
  late AuthRepository _authRepository;

  HomeController(
      {required this.userId,
      UserRepository? userRepository,
      AuthRepository? authRepository}) {
    _userRepository = userRepository ?? UserRepository();
    _authRepository = authRepository ?? AuthRepository();
    getUser();
  }

  User get user => _userRepository.user;

  Future<void> getUser() async {
    setState(ViewState.busy);
    try {
      Result result = await _userRepository.getUser(id: userId);

      if (result.status) {
        setState(ViewState.idle);
        return;
      }
      setErrorMessage(result.message ?? '');
      setState(ViewState.error);
    } on UnauthorizedException {
      rethrow;
    } on ServiceUnavailableException catch (e) {
      setErrorMessage(e.toString());
      setState(ViewState.error);
    } catch (e) {
      setErrorMessage(ErrorMessages.unknownError);
      setState(ViewState.error);
    }
  }

  Future<void> logoutUser() async {
    setState(ViewState.busy);
    try {
      await _authRepository.logoutUser();
    } catch (e) {
      //Should go idle even with errors
    } finally {
      setState(ViewState.idle);
    }
  }
}
