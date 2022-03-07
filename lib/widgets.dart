import 'package:flutter/material.dart';
import 'package:push_app/textstyles.dart';

import 'colors.dart';

class MmmWidgets {
  static Widget messageReceived(String msg, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: 253, maxHeight: double.infinity, minHeight: 58),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                    color: kMessage),
                child: Text(
                  msg,
                  style: MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              time,
              style: MmmTextStyles.caption(textColor: gray4),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ],
    );
  }

  static Widget messageSent(String msg, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: 253, maxHeight: double.infinity, minHeight: 58),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16)),
                    color: kLight4),
                child: Text(
                  msg,
                  style: MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              time,
              style: MmmTextStyles.caption(textColor: gray4),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ],
    );
  }
}
