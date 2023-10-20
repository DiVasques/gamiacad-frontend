import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/ui/controllers/default_dialog_controller.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('DefaultDialogController', () {
    late DefaultDialogController dialogController;

    group('takeAction', () {
      test('should complete when no error message', () async {
        // Arrange
        actionMethod() async {
          return null;
        }

        dialogController = DefaultDialogController(
          actionMethod: actionMethod,
        );

        // Act
        bool result = await dialogController.takeAction();

        // Assert
        expect(result, true);
        expect(dialogController.state, ViewState.busy);
        expect(dialogController.errorMessage, '');
      });

      test('should give error when receives error message', () async {
        // Arrange
        String errorMessage = 'errorMessage';
        actionMethod() async {
          return errorMessage;
        }

        dialogController = DefaultDialogController(
          actionMethod: actionMethod,
        );

        // Act
        bool result = await dialogController.takeAction();

        // Assert
        expect(result, false);
        expect(dialogController.state, ViewState.error);
        expect(dialogController.errorMessage, errorMessage);
      });
    });
  });
}
