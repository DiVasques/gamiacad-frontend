import 'package:flutter/material.dart';
import 'package:gami_acad/repository/models/base_mission.dart';
import 'package:gami_acad/ui/controllers/mission_controller.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';
import 'package:gami_acad/ui/utils/app_texts.dart';
import 'package:gami_acad/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad/ui/widgets/default_list_tile.dart';
import 'package:gami_acad/ui/widgets/default_separated_list_view.dart';
import 'package:provider/provider.dart';

class MissionListView extends StatelessWidget {
  const MissionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MissionController>(
      builder: (context, missionController, _) {
        List<BaseMission> missionsList = getMissionsList(missionController);
        String title = getTitle(missionController);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => missionController.getUserMissions(),
                child: () {
                  if (missionsList.isEmpty) {
                    return CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.remove_circle_outline_rounded,
                                color: Colors.black54,
                              ),
                              Text(
                                  'Não há missões ${title.toLowerCase()} no momento.'),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return DefaultSeparatedListView(
                    itemCount: missionsList.length,
                    itemBuilder: (context, index) {
                      BaseMission mission = missionsList.elementAt(index);
                      return DefaultListTile(
                        title: mission.name,
                        subTitle: '#${mission.number}',
                        trailingTextTitle: 'Pontos:',
                        trailingText: mission.points.toStringDecimal(),
                        onTap: () async {
                          await Navigator.of(context).pushNamed(
                            GenericRouter.missionDetailsRoute,
                            arguments: {
                              'userId': missionController.userId,
                              'mission': mission,
                              'canSignOn': canSignOn(missionController)
                            },
                          );
                          missionController.getUserMissions();
                        },
                      );
                    },
                  );
                }(),
              ),
            ),
          ],
        );
      },
    );
  }

  List<BaseMission> getMissionsList(MissionController missionController) {
    switch (missionController.navigationIndex) {
      case 0:
        return missionController.userMissions.active;
      case 1:
        return missionController.userMissions.participating;
      case 2:
        return missionController.userMissions.completed;
      default:
        return missionController.userMissions.active;
    }
  }

  String getTitle(MissionController missionController) {
    switch (missionController.navigationIndex) {
      case 0:
        return AppTexts.missionActive;
      case 1:
        return AppTexts.missionParticipating;
      case 2:
        return AppTexts.missionCompleted;
      default:
        return '';
    }
  }

  bool canSignOn(MissionController missionController) {
    switch (missionController.navigationIndex) {
      case 0:
        return true;
      case 1:
      case 2:
      default:
        return false;
    }
  }
}
