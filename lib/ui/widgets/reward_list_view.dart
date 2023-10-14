import 'package:flutter/material.dart';
import 'package:gami_acad/repository/models/base_reward.dart';
import 'package:gami_acad/ui/controllers/reward_controller.dart';
import 'package:gami_acad/ui/utils/app_texts.dart';
import 'package:gami_acad/ui/utils/int_extension.dart';
import 'package:gami_acad/ui/widgets/default_list_tile.dart';
import 'package:gami_acad/ui/widgets/default_separated_list_view.dart';
import 'package:provider/provider.dart';

class RewardListView extends StatelessWidget {
  const RewardListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardController>(
      builder: (context, rewardController, _) {
        List<BaseReward> rewardsList = getRewardsList(rewardController);
        String title = getTitle(rewardController);
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
                onRefresh: () => rewardController.getUserRewards(),
                child: () {
                  if (rewardsList.isEmpty) {
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
                                  'Não há recompensas ${title.toLowerCase()} no momento.'),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return DefaultSeparatedListView(
                    itemCount: rewardsList.length,
                    itemBuilder: (context, index) {
                      BaseReward reward = rewardsList.elementAt(index);
                      return DefaultListTile(
                        title: '#${reward.number}',
                        subTitle: reward.name,
                        trailingTextTitle: 'Preço:',
                        trailingText: reward.price.toStringDecimal(),
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

  List<BaseReward> getRewardsList(RewardController rewardController) {
    switch (rewardController.navigationIndex) {
      case 0:
        return rewardController.userRewards.available;
      case 1:
        return rewardController.userRewards.claimed;
      case 2:
        return rewardController.userRewards.received;
      default:
        return rewardController.userRewards.available;
    }
  }

  String getTitle(RewardController rewardController) {
    switch (rewardController.navigationIndex) {
      case 0:
        return AppTexts.rewardAvailable;
      case 1:
        return AppTexts.rewardClaimed;
      case 2:
        return AppTexts.rewardReceived;
      default:
        return '';
    }
  }
}