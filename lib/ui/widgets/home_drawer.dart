import 'package:flutter/material.dart';
import 'package:gami_acad/ui/controllers/home_controller.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';
import 'package:gami_acad/ui/utils/string_extension.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        return homeController.state == ViewState.busy
            ? Container()
            : Drawer(
                child: SafeArea(
                  child: homeController.state == ViewState.error
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 20, bottom: 5),
                                        alignment: Alignment.bottomLeft,
                                        height: 50,
                                        child: Text(
                                          "Erro ao carregar os dados",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: theme.primaryColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ListTile(
                                        title: const Text("Recarregar"),
                                        trailing: Icon(
                                          Icons.replay_outlined,
                                          color: theme.primaryColor,
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          homeController.getUser();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: const Text("Sair"),
                              trailing: Icon(
                                Icons.exit_to_app,
                                color: theme.primaryColor,
                              ),
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  GenericRouter.loginRoute,
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 20, bottom: 5),
                                        alignment: Alignment.bottomLeft,
                                        height: 50,
                                        child: Text(
                                          "Bem-vindo, ${homeController.user.name.split(" ")[0].capitalize()}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: theme.primaryColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ListTile(
                                        title: const Text("Recarregar"),
                                        trailing: Icon(
                                          Icons.replay_outlined,
                                          color: theme.primaryColor,
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          homeController.getUser();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: const Text("Sair"),
                              trailing: Icon(
                                Icons.exit_to_app,
                                color: theme.primaryColor,
                              ),
                              onTap: () {
                                homeController.logoutUser();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  GenericRouter.loginRoute,
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                ),
              );
      },
    );
  }
}
