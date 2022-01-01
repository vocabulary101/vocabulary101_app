import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocabulary101_app/app/core/icons/v101_icons.dart';

class DialogScaffold extends StatelessWidget {
  final String? title;
  final Widget content;
  final Widget? buttons;
  final double? maxWidth;
  final double? contentHorizontalPadding;
  final bool scrollable;

  const DialogScaffold({
    Key? key,
    this.title,
    required this.content,
    this.buttons,
    this.maxWidth,
    this.contentHorizontalPadding = 20,
    this.scrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      contentPadding: const EdgeInsets.all(0),
      scrollable: scrollable,
      content: Container(
        width: maxWidth != null
            ? Get.width <= maxWidth!
                ? Get.width - 20
                : maxWidth
            : null,
        padding: const EdgeInsets.symmetric(vertical: 23),
        decoration: BoxDecoration(
          color: Get.theme.dialogTheme.backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          title!,
                          style: Get.theme.textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        V101Icons.close,
                        color: Colors.grey,
                        size: 14,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: contentHorizontalPadding!,
              ),
              child: content,
            ),
            if (buttons != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(23, 30, 23, 0),
                child: buttons!,
              ),
          ],
        ),
      ),
    );
  }
}
