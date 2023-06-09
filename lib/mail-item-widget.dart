import 'package:flutter/material.dart';
import 'controller.dart';

class MailItemWidget extends StatelessWidget {
  const MailItemWidget({
    required this.fromName,
    required this.subject,
    required this.content,
    required this.time,
    required this.isRead,
    Key? key,
  }) : super(key: key);
  final String fromName, subject, content, time;
  final bool isRead;
  @override
  Widget build(BuildContext context) {
    final mysize = MediaQuery.of(context).size;
    // double kPadding = mysize.width * 0.025 > 0 ? mysize.width * 0.025 : 2;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black26,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Expanded(
        flex: 1,
        child: Row(
          children: [
            CircleAvatar(
              child: Text(fromName.substring(0, 1)),
            ),
            SizedBox(width: 3),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          fromName,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                                isRead ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Text(
                    subject,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isRead ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
