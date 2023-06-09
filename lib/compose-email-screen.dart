import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'controller.dart';
import 'home-page.dart';
import 'package:get/get.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({Key? key, required void onSendMessage})
      : super(key: key);

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  bool expandMore = false;

  bool showCcField = false;

  bool showBccField = false;

  final List<String> menuTabItems = [
    'Schedule send',
    "Confidential Mode",
    "Discard",
    "Settings",
    "help and feedback"
  ];

  @override
  Widget build(BuildContext context) {
    final mysize = MediaQuery.of(context).size;
    // double kPadding = mysize.width * 0.025 > 0 ? mysize.width * 0.025 : 2;
    Controller controller = Get.find();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 24,
            color: Colors.black54,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Compose',
            style: TextStyle(color: Colors.black54),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.attachment_outlined),
              iconSize: 24,
              color: Colors.black54,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.send),
              iconSize: 24,
              color: Colors.black54,
              onPressed: () {
                try {
                  final data = FirebaseFirestore.instance
                      .collection('${controller.toPhoneNumber.text}');
                  data.add({
                    'fromName':
                        '${controller.countryCode.text + controller.phoneNumber.text}',
                    'subject': '${controller.subject}',
                    'content': '${controller.content}',
                    'time': '1:04 pm',
                    'isRead': false
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Success'),
                        content: Text('Mail has been sent.'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  print(e);
                }
              },
            ),
            InkWell(
              child: PopupMenuButton(
                iconSize: 24,
                icon: const Icon(
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
                onSelected: (value) {
                  setState(() {
                    if (value == 'Cc') {
                      showCcField = true;
                    } else if (value == 'Bcc') {
                      showBccField = true;
                    }
                  });
                },
              ),
            ),
          ],
        ),
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              TextFormField(
                initialValue:
                    controller.countryCode.text + controller.phoneNumber.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(top: 3, left: 2, right: 2),
                    child: Text(
                      'From',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.expand_more),
                    color: Colors.black54,
                    onPressed: () {},
                  ),
                ),
              ),
              TextField(
                controller: controller.toPhoneNumber,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(top: 3, left: 2, right: 2),
                    child: Text(
                      'To',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.expand_more),
                    color: Colors.black54,
                    onPressed: () {
                      setState(() {
                        expandMore = !expandMore;
                      });
                    },
                  ),
                ),
              ),
              if (expandMore)
                const Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 3, left: 2, right: 2),
                          child: Text(
                            'Cc',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 3, left: 2, right: 2),
                          child: Text(
                            'Bcc',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              TextField(
                controller: controller.subject,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2, left: 2, right: 2),
                  hintText: 'Subject',
                ),
              ),
              TextField(
                controller: controller.content,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2, left: 2, right: 2),
                  hintText: 'Compose',
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ));
  }
}
