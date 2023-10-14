import 'package:flutter/material.dart';
import 'package:gami_acad/repository/models/base_mission.dart';
import 'package:gami_acad/ui/controllers/mission_controller.dart';
import 'package:gami_acad/ui/utils/int_extension.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        title: '#${mission.number}',
                        subTitle: mission.name,
                        trailingTextTitle: 'Pontos:',
                        trailingText: mission.points.toStringDecimal(),
                        onTap: () {},
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
        return 'Ativas';
      case 1:
        return 'Inscritas';
      case 2:
        return 'Concluídas';
      default:
        return '';
    }
  }
}