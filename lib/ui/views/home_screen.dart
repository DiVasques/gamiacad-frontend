import 'package:flutter/material.dart';
import 'package:gami_acad/ui/controllers/home_controller.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';
import 'package:gami_acad/ui/utils/app_colors.dart';
import 'package:gami_acad/ui/utils/app_texts.dart';
import 'package:gami_acad/ui/utils/dimensions.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:gami_acad/ui/widgets/default_error_screen.dart';
import 'package:gami_acad/ui/widgets/default_loading_screen.dart';
import 'package:gami_acad/ui/widgets/home_drawer.dart';
import 'package:gami_acad/ui/widgets/home_user_info_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final String? userId;
  final GlobalKey _scaffoldKey = GlobalKey();
  HomeScreen({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => HomeController(userId: userId!),
      child: Consumer<HomeController>(
        builder: (context, homeController, _) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: const HomeDrawer(),
            appBar: AppBar(
              title: Text(
                AppTexts.gamiAcad,
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            body: () {
              switch (homeController.state) {
                case ViewState.busy:
                  return const DefaultLoadingScreen();
                case ViewState.error:
                  return DefaultErrorScreen(
                    message: homeController.errorMessage,
                    onPressed: () => homeController.getUser(),
                  );
                case ViewState.idle:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () => homeController.getUser(),
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            children: [
                              const HomeUserInfoCard(),
                              const SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                direction: Axis.horizontal,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 100,
                                    child: Card(
                                      elevation: Dimensions.cardElevation,
                                      child: InkWell(
                                        onTap: () async {
                                          await Navigator.of(context).pushNamed(
                                            GenericRouter.missionRoute,
                                            arguments: userId,
                                          );
                                          homeController.getUser();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.checklist_rounded,
                                                color: AppColors.primaryColor,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Missões',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 100,
                                    child: Card(
                                      elevation: Dimensions.cardElevation,
                                      child: InkWell(
                                        onTap: () async {
                                          await Navigator.of(context).pushNamed(
                                            GenericRouter.rewardRoute,
                                            arguments: userId,
                                          );
                                          homeController.getUser();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.shopping_basket_rounded,
                                                color: AppColors.primaryColor,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Recompensas',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
              }
            }(),
          );
        },
      ),
    );
  }
}
