import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocabulary101_app/app/widgets/dialog_scaffold.dart';

Future<bool?> cardStatusColorsHelpDialog() async {
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
      title: 'The 4 Colors of Vocabulary 101'.tr,
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
          'Are the lower buttons and their colors confusing you? These are their meanings:'
              .tr,
          style: Get.textTheme.bodyText1,
        ),
        const SizedBox(height: 20),
        Text(
          'AGAIN'.tr,
          style: Get.textTheme.headline5!.copyWith(
            color: const Color(0xFFEF476F),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Words that are still unknown to you, and you need to review many more times.'
              .tr,
          style: Get.textTheme.bodyText1,
        ),
        const SizedBox(height: 20),
        Text(
          'HARD'.tr,
          style: Get.textTheme.headline5!.copyWith(
            color: const Color(0xFFF99F36),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Words that you know, but that you need to review several more times to remember them.'
              .tr,
          style: Get.textTheme.bodyText1,
        ),
        const SizedBox(height: 20),
        Text(
          'GOOD'.tr,
          style: Get.textTheme.headline5!.copyWith(
            color: const Color(0xFF1B9AAA),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Cards that you have already learned well, but that you would like to review them in some time.'
              .tr,
          style: Get.textTheme.bodyText1,
        ),
        const SizedBox(height: 20),
        Text(
          'EASY'.tr,
          style: Get.textTheme.headline5!.copyWith(
            color: const Color(0xFF06D6A0),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Cards that you have already learned very well, these cards will no longer be presented to you.'
              .tr,
          style: Get.textTheme.bodyText1,
        ),
        const SizedBox(height: 30),
        Text(
          'You will see these colors everywhere in this app.'.tr,
          style: Get.textTheme.bodyText1,
        ),
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
