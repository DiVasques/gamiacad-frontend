import 'package:flutter/material.dart';
import 'package:gami_acad/ui/controllers/home_controller.dart';
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
              iconTheme: IconThemeData(color: theme.primaryColor),
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                'GamiAcad',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            backgroundColor: Colors.white,
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
                            children: const [
                              HomeUserInfoCard(),
                              SizedBox(
                                height: 10,
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
