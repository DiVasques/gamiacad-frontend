import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gami_acad/repository/models/base_mission.dart';
import 'package:gami_acad/ui/controllers/mission_details_controller.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';
import 'package:gami_acad/ui/utils/app_texts.dart';
import 'package:gami_acad/ui/utils/extensions/date_extension.dart';
import 'package:gami_acad/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:gami_acad/ui/widgets/default_error_screen.dart';
import 'package:gami_acad/ui/widgets/default_loading_screen.dart';
import 'package:gami_acad/ui/widgets/default_action_dialog.dart';
import 'package:provider/provider.dart';

class MissionDetailsScreen extends StatelessWidget {
  final String userId;
  final BaseMission mission;
  final bool canSignOn;
  const MissionDetailsScreen({
    Key? key,
    required this.userId,
    required this.mission,
    required this.canSignOn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MissionDetailsController(userId: userId, mission: mission),
      child: Consumer<MissionDetailsController>(
        builder: (context, missionDetailsController, _) {
          return Scaffold(
            appBar: AppBar(),
            floatingActionButton:
                buildFloatingActionButton(missionDetailsController, context),
            body: () {
              switch (missionDetailsController.state) {
                case ViewState.busy:
                  return const DefaultLoadingScreen();
                case ViewState.error:
                  return DefaultErrorScreen(
                    message: missionDetailsController.errorMessage,
                    onPressed: () {},
                  );
                case ViewState.idle:
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                missionDetailsController.mission.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '#${missionDetailsController.mission.number}',
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 15,
                            bottom: 200,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                '${AppTexts.points}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                missionDetailsController.mission.points
                                    .toStringDecimal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                '${AppTexts.expirationDate}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${missionDetailsController.mission.expirationDate.toLocalDateExtendedString()} ${AppTexts.at} ${missionDetailsController.mission.expirationDate.toLocalTimeString()}h',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                '${AppTexts.details}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                missionDetailsController.mission.description,
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
              }
            }(),
          );
        },
      ),
    );
  }

  Widget? buildFloatingActionButton(
    MissionDetailsController missionDetailsController,
    BuildContext context,
  ) {
    if (missionDetailsController.state != ViewState.idle) {
      return null;
    }
    if (canSignOn) {
      return FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => DefaultActionDialog(
              titleText: AppTexts.confirmation,
              actionText: AppTexts.yes,
              actionMethod: missionDetailsController.subscribeOnMission,
              routeToCallback: GenericRouter.missionRoute,
              contentText: AppTexts.missionSignOnConfirmation,
              successText: AppTexts.missionSignOnSuccess,
            ),
          );
        },
        tooltip: AppTexts.missionSignOn,
        child: const FaIcon(FontAwesomeIcons.fileSignature, size: 20),
      );
    }
    return null;
  }
}
