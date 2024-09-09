import 'package:flutter/material.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';

class OverviewPopupLogic {
  static void showDeleteConfirmation(BuildContext context, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          title: 'Eintrag löschen',
          agreeText: 'Löschen',
          content: Column(
            children: [
              Text("Möchten Sie die Zeit wirklich löschen?"),
              const Text(
                  "Diese Aktion kann nicht Rückgängig gemacht werden."),
            ],
          ),
          mode: PopUpMode.warning,
          onAgree: () {
            onDelete();
            Navigator.of(context).pop();
          },
          onDisagree: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  static void showEditPopup(BuildContext context, Function(String) onEdit) {
    final TextEditingController controller = TextEditingController(text: 'nix');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          title: 'Zeit bearbeiten',
          agreeText: 'Bearbeiten',
          content: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'nix',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          mode: PopUpMode.agree,
          onAgree: () {
            onEdit(controller.text);
            Navigator.of(context).pop();
          },
          onDisagree: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
