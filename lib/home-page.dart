import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'compose-email-screen.dart';
import 'controller.dart';
import 'mail-detail-screen.dart';
import 'mail-item-widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mysize = MediaQuery.of(context).size;
    // double kPadding = mysize.width * 0.025 > 0 ? mysize.width * 0.025 : 2;
    Controller controller = Get.put(Controller());
    controller.countryCode.text = '+91';
    controller.phoneNumber.text = '8688260099';
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final CollectionReference userdata = FirebaseFirestore.instance.collection(
        '${controller.countryCode.text + controller.phoneNumber.text}');
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Phone Mail',
                    style: TextStyle(
                      fontSize: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 2),
                const Divider(
                  height: 2,
                  color: Colors.black54,
                ),
                SizedBox(height: 2),
                const ListTile(
                  leading: Icon(Icons.inbox),
                  title: Text('All Inbox'),
                ),
                SizedBox(height: 2),
                const Divider(
                  height: 2,
                  color: Colors.black54,
                ),
                const ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text('Primary'),
                ),
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Social'),
                ),
                const ListTile(
                  leading: Icon(Icons.tag),
                  title: Text('Promotion'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('ALL LABLES',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                const ListTile(
                  leading: Icon(Icons.star_rate_outlined),
                  title: Text('Starred'),
                ),
                const ListTile(
                  leading: Icon(Icons.history_toggle_off),
                  title: Text('Snoozed'),
                ),
                const ListTile(
                  leading: Icon(Icons.drafts),
                  title: Text('Drafts'),
                ),
                const ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Bin'),
                ),
                const ListTile(
                  leading: Icon(Icons.send),
                  title: Text('Sent'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('OTHER APPS',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                const ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Calender'),
                ),
                const ListTile(
                  leading: Icon(Icons.contacts),
                  title: Text('Contact'),
                ),
                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                const ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('Help and feedback'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              //------------Header
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black26,
                      offset: Offset(2, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 24,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search here',
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            isDense: false,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => buildAccountSetting(),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage('assets/p1.jpg'),
                      ),
                    ),
                    SizedBox(width: 4),
                  ],
                ),
              ),
              SizedBox(height: 2),
              //------------Heading title
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'PRIMARY MAILS',
                  style: TextStyle(
                    color: Colors.black54,
                    wordSpacing: 3,
                  ),
                ),
              ),
              SizedBox(height: 3),
              //------------Content/Mails
              Expanded(
                  flex: 1,
                  child: StreamBuilder(
                    stream: userdata.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        print('userdata has documents in it');
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  snapshot.data!.docs[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return MailDetailScreen(
                                      fromName: documentSnapshot['fromName'],
                                      subject: documentSnapshot['subject'],
                                      content: documentSnapshot['content'],
                                      time: documentSnapshot['time'],
                                    );
                                  }));
                                },
                                child: MailItemWidget(
                                  fromName: documentSnapshot['fromName'],
                                  subject: documentSnapshot['subject'],
                                  content: documentSnapshot['content'],
                                  time: documentSnapshot['time'],
                                  isRead: documentSnapshot['isRead'],
                                ),
                              );
                            });
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ComposeScreen(
                    onSendMessage: null,
                  )));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.edit,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 2),
              const Text(
                'Compose',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAccountSetting() {
    // double kPadding = double.infinity * 0.025 > 0 ? double.infinity * 0.025 : 2;
    return Dialog(
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 3),
                AccountWidget(
                  name: 'Gautam Singh',
                  mail: 'gautam@p.com',
                  imgPath: 'assets/p1.jpg',
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  margin: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text('Manage your account',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700])),
                ),
                const Divider(height: 2, color: Colors.black45),
                SizedBox(height: 4),
                AccountWidget(
                  name: 'Kalpna Chawla',
                  mail: 'kalpna@kp.com',
                  imgPath: 'assets/p1.jpg',
                ),
                AccountWidget(
                  name: 'Parsuram',
                  mail: 'solid@bro.com',
                  imgPath: 'assets/p1.jpg',
                ),
                AccountWidget(
                  name: 'Alexendor DD',
                  mail: 'dummy@comp.com',
                  imgPath: 'assets/p1.jpg',
                ),
                SizedBox(height: 3),
                Container(
                  margin: EdgeInsets.only(left: 5, bottom: 2),
                  child: Row(children: [
                    Icon(Icons.person_add, size: 24, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text('Add another account',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700])),
                  ]),
                ),
                Divider(height: 2, color: Colors.black45),
                SizedBox(height: 2),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 2,
                  ),
                  child: Text('Sign out all accounts',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87.withOpacity(0.8))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//   Widget buildDrawerItem(IconData icon, String title, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedItem = index;
//         });
//         if (index == 9) {
//           // Check if "Sent" drawer item is clicked
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) {
//               return const SentMessagesScreen(); // Replace SentMessagesScreen with the actual screen that displays the sent messages
//             },
//           ));
//         }
//       },
//       child: Container(
//         padding:
//             EdgeInsets.symmetric(horizontal: kPadding, vertical: kPadding - 10),
//         margin: EdgeInsets.only(right: kPadding),
//         decoration: BoxDecoration(
//           color: index == _selectedItem ? Colors.blue.withOpacity(0.2) : null,
//           borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 24),
//             SizedBox(width: kPadding),
//             Text(title, style: TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    required this.name,
    required this.mail,
    required this.imgPath,
    Key? key,
  }) : super(key: key);
  final String name, mail, imgPath;
  @override
  Widget build(BuildContext context) {
    final mysize = MediaQuery.of(context).size;
    // double kPadding = mysize.width * 0.025 > 0 ? mysize.width * 0.025 : 2;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 3,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black26,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundImage: AssetImage(imgPath),
          ),
          SizedBox(width: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              Text(mail,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
