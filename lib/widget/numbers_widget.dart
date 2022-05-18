import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';

class NumbersWidget extends ConsumerWidget {
  String rating;
  NumbersWidget({required this.rating});
  @override
  Widget build(BuildContext context,WidgetRef ref) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, rating, 'rating'.tr()),
          buildDivider(),
          // buildButton(context, '35', 'Requests'),
          // buildDivider(),
          buildButton(context, ref.watch(ongoingRequestsProvider).length.toString(), 'ongoing_requests'.tr()),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
