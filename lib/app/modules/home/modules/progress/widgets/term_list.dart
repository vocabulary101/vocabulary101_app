import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:vocabulary101_app/app/core/icons/v101_icons.dart';
import 'package:vocabulary101_app/app/modules/home/controllers/home_controller.dart';

class ProgressTermList extends StatelessWidget {
  const ProgressTermList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      child: Obx(
        () => Scrollbar(
          isAlwaysShown: true,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            children: [
              for (var sessionCard in HomeController.to.userSessionCards)
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: ListTile(
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            V101Icons.card_list,
                            color: sessionCard.getStatusColor(),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            sessionCard.getStatusAsString().toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              color: sessionCard.getStatusColor(),
                            ),
                          ),
                        ],
                      ),
                      title: Text(sessionCard.term),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          sessionCard.lastUpdateAt
                              .subtract(const Duration(seconds: 1))
                              .relative(appendIfAfter: 'ago'),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
