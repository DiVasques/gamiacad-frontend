import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gami_acad/ui/controllers/mission_controller.dart';
import 'package:gami_acad/ui/utils/app_texts.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:gami_acad/ui/widgets/default_error_screen.dart';
import 'package:gami_acad/ui/widgets/default_loading_screen.dart';
import 'package:gami_acad/ui/widgets/mission_list_view.dart';
import 'package:provider/provider.dart';

class MissionScreen extends StatelessWidget {
  final String? userId;
  const MissionScreen({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MissionController(userId: userId!),
      child: Consumer<MissionController>(
        builder: (context, missionController, _) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: missionController.navigationIndex,
              onTap: (int index) {
                missionController.navigationIndex = index;
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.list, size: 20),
                  label: AppTexts.missionActive,
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.fileSignature, size: 20),
                  label: AppTexts.missionParticipating,
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.circleCheck, size: 20),
                  label: AppTexts.missionCompleted,
                ),
              ],
            ),
            appBar: AppBar(),
            body: () {
              switch (missionController.state) {
                case ViewState.busy:
                  return const DefaultLoadingScreen();
                case ViewState.error:
                  return DefaultErrorScreen(
                    message: missionController.errorMessage,
                    onPressed: () => missionController.getUserMissions(),
                  );
                case ViewState.idle:
                  return const MissionListView();
              }
            }(),
          );
        },
      ),
    );
  }
}
