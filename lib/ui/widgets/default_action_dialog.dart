import 'package:flutter/material.dart';
import 'package:gami_acad/ui/controllers/default_dialog_controller.dart';
import 'package:gami_acad/ui/utils/app_texts.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:provider/provider.dart';

class DefaultActionDialog extends StatelessWidget {
  final String titleText;
  final String actionText;
  final Future<String?> actionMethod;
  final String routeToCallback;
  final String? contentText;

  const DefaultActionDialog({
    super.key,
    required this.titleText,
    required this.actionText,
    required this.actionMethod,
    required this.routeToCallback,
    this.contentText,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DefaultDialogController>(
      create: (_) => DefaultDialogController(actionMethod: actionMethod),
      child: Consumer<DefaultDialogController>(
        builder: (context, dialogController, _) {
          return WillPopScope(
            onWillPop: () async {
              if (dialogController.state == ViewState.busy) {
                return true;
              }
              return true;
            },
            child: () {
              switch (dialogController.state) {
                case ViewState.idle:
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        titleText,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    content: contentText != null
                        ? Text(
                            '$contentText',
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          )
                        : null,
                    actions: [
                      TextButton(
                        child: const Text(AppTexts.cancel),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(actionText),
                        onPressed: () {
                          dialogController.takeAction().then((result) {
                            if (result) {
                              Navigator.of(context).popUntil(
                                (route) =>
                                    route.settings.name == routeToCallback,
                              );
                            }
                          });
                        },
                      ),
                    ],
                  );
                case ViewState.busy:
                  return const AlertDialog(
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                case ViewState.error:
                  return AlertDialog(
                    title: const Center(
                      child: Text(
                        AppTexts.error,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    content: Text(
                      dialogController.errorMessage,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(AppTexts.cancel),
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
