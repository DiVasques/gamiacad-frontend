import 'package:flutter/material.dart';
import 'package:gami_acad/ui/controllers/home_controller.dart';
import 'package:gami_acad/ui/utils/dimensions.dart';
import 'package:gami_acad/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad/ui/utils/extensions/string_extension.dart';
import 'package:provider/provider.dart';

class HomeUserInfoCard extends StatelessWidget {
  const HomeUserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        return Card(
          elevation: Dimensions.cardElevation,
          child: Padding(
            padding: const EdgeInsets.all(8.5),
            child: Column(
              children: <Widget>[
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => {},
                  child: Column(
                    children: [
                      Dimensions.heightSpacer(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Dimensions.widthSpacer(),
                          Expanded(
                            child: Text(
                              homeController.user.name.toTitleCase(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      Dimensions.heightSpacer(Dimensions.smallPadding * 2),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                  indent: Dimensions.smallPadding,
                  endIndent: Dimensions.smallPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 10,
                      child: Container(
                        height: 70,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Meus Créditos',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Dimensions.heightSpacer(10.0),
                            Text(
                              homeController.user.balance.toStringDecimal(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: 2.1,
                        height: 70,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    Flexible(
                      flex: 10,
                      child: Container(
                        height: 70,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Pontos Totais',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Dimensions.heightSpacer(10.0),
                            Text(
                              homeController.user.totalPoints.toStringDecimal(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
