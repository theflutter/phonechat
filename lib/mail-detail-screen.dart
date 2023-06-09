import 'dart:math';

import 'package:flutter/material.dart';
import 'controller.dart';

class MailDetailScreen extends StatelessWidget {
  MailDetailScreen(
      {required this.subject,
      required this.fromName,
      required this.time,
      required this.content});
  final String subject, fromName, time, content;
  final List<String> menuTabItems = [
    "Move to",
    "Snooze",
    "Mark as important",
    "Mute",
    "Print",
    "Report spam",
    "Help and feedback"
  ];

  final List<String> menuMailItems = [
    "Reply all",
    "Forward",
    "Add star",
    "Print",
    "Mark unread from here",
    "Block GitHub",
  ];
  @override
  Widget build(BuildContext context) {
    final mysize = MediaQuery.of(context).size;
    // double kPadding = mysize.width * 0.025 > 0 ? mysize.width * 0.025 : 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24,
          color: Colors.black54,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.archive_outlined),
            iconSize: 24,
            color: Colors.black54,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            iconSize: 24,
            color: Colors.black54,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.email),
            iconSize: 24,
            color: Colors.black54,
            onPressed: () {},
          ),
          InkWell(
            child: PopupMenuButton(
              iconSize: 24,
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.black54,
              ),
              itemBuilder: (context) => menuTabItems
                  .map(
                    (itemName) => PopupMenuItem(
                      child: Text(itemName),
                      value: itemName,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //-------------Title Widget
          Padding(
            padding: EdgeInsets.all(1),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: mysize.width - 10,
                    child: Text(
                      subject,
                      style: TextStyle(
                          color: Colors.black87.withOpacity(0.8), fontSize: 17),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          //-----------Mail subject Widget
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
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
                          Text(
                            fromName,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            time,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            'to me',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Icon(
                            Icons.expand_more,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(icon: Icon(Icons.keyboard_return), onPressed: () {}),
                InkWell(
                  child: PopupMenuButton(
                    iconSize: 24,
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.black54,
                    ),
                    itemBuilder: (context) => menuMailItems
                        .map(
                          (itemName) => PopupMenuItem(
                            child: Text(itemName),
                            value: itemName,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          //-----------------------Mail Info/Content
          Padding(
            padding: EdgeInsets.all(1),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          //-----------------------Last Three Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.06),
                  primary: Colors.black54,
                ),
                onPressed: () {},
                icon: Icon(Icons.reply),
                label: Text('Reply'),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.06),
                  primary: Colors.black54,
                ),
                onPressed: () {},
                icon: Icon(Icons.reply_all),
                label: Text('Reply all'),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.06),
                  primary: Colors.black54,
                ),
                onPressed: () {},
                icon: Transform(
                  transform: Matrix4.rotationY(pi),
                  alignment: Alignment.center,
                  child: Icon(Icons.reply),
                ),
                label: Text('Forward'),
              )
            ],
          )
        ],
      ),
    );
  }
}
