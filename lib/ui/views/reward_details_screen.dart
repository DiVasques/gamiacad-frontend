import 'package:flutter/material.dart';
import 'package:gami_acad/repository/models/base_reward.dart';
import 'package:gami_acad/ui/controllers/reward_details_controller.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';
import 'package:gami_acad/ui/utils/app_colors.dart';
import 'package:gami_acad/ui/utils/app_texts.dart';
import 'package:gami_acad/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:gami_acad/ui/widgets/default_action_dialog.dart';
import 'package:gami_acad/ui/widgets/default_error_screen.dart';
import 'package:gami_acad/ui/widgets/default_loading_screen.dart';
import 'package:provider/provider.dart';

class RewardDetailsScreen extends StatelessWidget {
  final String userId;
  final BaseReward reward;
  final bool canClaim;
  final bool canCancelClaim;
  const RewardDetailsScreen({
    Key? key,
    required this.userId,
    required this.reward,
    required this.canClaim,
    required this.canCancelClaim,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RewardDetailsController(userId: userId, reward: reward),
      child: Consumer<RewardDetailsController>(
        builder: (context, rewardDetailsController, _) {
          return Scaffold(
            appBar: AppBar(),
            floatingActionButton:
                buildFloatingActionButton(rewardDetailsController, context),
            body: () {
              switch (rewardDetailsController.state) {
                case ViewState.busy:
                  return const DefaultLoadingScreen();
                case ViewState.error:
                  return DefaultErrorScreen(
                    message: rewardDetailsController.errorMessage,
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
                                rewardDetailsController.reward.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '#${rewardDetailsController.reward.number}',
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
                                '${AppTexts.price}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                rewardDetailsController.reward.price
                                    .toStringDecimal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                '${AppTexts.rewardAvailableQuantity}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                rewardDetailsController.reward.availability
                                    .toString(),
                              ),
                              ...?() {
                                if ((rewardDetailsController.reward.count ??
                                        0) >
                                    0) {
                                  return <Widget>[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      '${AppTexts.rewardAlreadyClaimed}:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      rewardDetailsController.reward.count
                                          .toString(),
                                    ),
                                  ];
                                }
                              }(),
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
                                rewardDetailsController.reward.description,
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
    RewardDetailsController rewardDetailsController,
    BuildContext context,
  ) {
    if (rewardDetailsController.state != ViewState.idle) {
      return null;
    }
    if (canClaim) {
      return FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => DefaultActionDialog(
              titleText: AppTexts.confirmation,
              actionText: AppTexts.yes,
              actionMethod: rewardDetailsController.claimReward,
              routeToCallback: GenericRouter.rewardRoute,
              contentText: AppTexts.rewardClaimConfirmation,
            ),
          );
        },
        tooltip: AppTexts.rewardClaim,
        child: const Icon(Icons.shopping_cart),
      );
    }
    if (canCancelClaim) {
      return FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => DefaultActionDialog(
              titleText: AppTexts.confirmation,
              actionText: AppTexts.yes,
              actionMethod: rewardDetailsController.cancelClaim,
              routeToCallback: GenericRouter.rewardRoute,
              contentText: AppTexts.rewardCancelClaimConfirmation,
            ),
          );
        },
        tooltip: AppTexts.rewardCancelClaim,
        backgroundColor: AppColors.cancel,
        child: const Icon(Icons.remove_shopping_cart),
      );
    }
    return null;
  }
}
