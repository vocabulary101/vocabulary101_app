import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocabulary101_app/app/widgets/dialog_scaffold.dart';

Future<bool?> synchronizationDialog() async {
  return await Get.dialog<bool>(
    const _AlertDialog(),
  );
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogScaffold(
      maxWidth: 470,
      title: 'Synchronization'.tr,
      content: const _DialogContent(),
      buttons: const _DialogButtons(),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          'Coming soon, synchronization of all your data through Google Drive.'
              .tr,
          style: Get.textTheme.bodyText1,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _DialogButtons extends StatelessWidget {
  const _DialogButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.end,
      children: [
        OutlinedButton(
          child: Text('gral.gotIt'.tr.toUpperCase()),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 26,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
