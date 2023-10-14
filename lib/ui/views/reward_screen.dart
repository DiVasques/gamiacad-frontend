import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gami_acad/ui/controllers/reward_controller.dart';
import 'package:gami_acad/ui/utils/app_texts.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:gami_acad/ui/widgets/default_error_screen.dart';
import 'package:gami_acad/ui/widgets/default_loading_screen.dart';
import 'package:gami_acad/ui/widgets/reward_list_view.dart';
import 'package:provider/provider.dart';

class RewardScreen extends StatelessWidget {
  final String? userId;
  const RewardScreen({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RewardController(userId: userId!),
      child: Consumer<RewardController>(
        builder: (context, rewardController, _) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: rewardController.navigationIndex,
              onTap: (int index) {
                rewardController.navigationIndex = index;
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.list, size: 20),
                  label: AppTexts.rewardAvailable,
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.fileSignature, size: 20),
                  label: AppTexts.rewardClaimed,
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.circleCheck, size: 20),
                  label: AppTexts.rewardReceived,
                ),
              ],
            ),
            appBar: AppBar(),
            backgroundColor: Colors.white,
            body: () {
              switch (rewardController.state) {
                case ViewState.busy:
                  return const DefaultLoadingScreen();
                case ViewState.error:
                  return DefaultErrorScreen(
                    message: rewardController.errorMessage,
                    onPressed: () => rewardController.getUserRewards(),
                  );
                case ViewState.idle:
                  return const RewardListView();
              }
            }(),
          );
        },
      ),
    );
  }
}
