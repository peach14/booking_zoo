import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/services/local_storage.dart';
import '../../animal/views/list_of_animals.dart';
import '../../auth/controler/login_controller.dart';
import '../../room_animal/views/u_room.dart';
import '../../round_booking/component/u_select_round.dart';
import '../controller/provider.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  int itemInBody = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: itemInBody == 1
            ? const Text('สัตว์ทั้งหมด')
            : itemInBody == 2
                ? const Text('ห้องทั้งหมด')
                : itemInBody == 3
                    ? const Text('รอบการแสดง')
                    : const Text('ไม่มีข้อมูล'),
        actions: [
          IconButton(
              onPressed: () async {
                print(await LocalStorage.instance.getDBAdmin());
              },
              icon: const Icon(Icons.accessibility_new_sharp))
        ],
      ),
      body: itemInBody == 1
          ? const ListOfAnimals()
          : itemInBody == 2
              ? const URoom()
              : itemInBody == 3
                  ? const PageViewPage()
                  : const Text("No DATA"),
    ));
  }

  Container itemInDrawer(
      BuildContext context, Icon fIcon, String name, VoidCallback ontap,
      {Icon? lIcon, Color? color}) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20)),
              // side: BorderSide(
              //   width: 0.9,
              //   color: Color.fromARGB(255, 5, 5, 5),
              // )
            ),
          ),
          onPressed: ontap,
          child: Row(
            children: [
              fIcon,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(name, style: TextStyle(color: Colors.blue[700])),
            ],
          ),
        ));
  }

  Drawer buildDrawer(BuildContext context) {
    final data = ref.watch(dataCustomer);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://storage.googleapis.com/fastwork-static/79e9c1b7-8d32-4c8f-8067-68d479c97c40.jpg",
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(data),
            ],
          ),
        ),
        const Divider(height: 3, color: Colors.black54),
        Container(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.09),
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.668,
          //  color: Colors.blue,
          child: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  itemInDrawer(
                      color: itemInBody == 1 ? Colors.blue[200] : Colors.white,
                      context,
                      const Icon(Icons.adb, color: Colors.blue),
                      "รายชื่อสัตว์", () {
                    itemInBody = 1;
                    setState(() {});
                    Navigator.pop(context);
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Myproduct(),));
                  }),
                  itemInDrawer(
                      color: itemInBody == 2 ? Colors.blue[200] : Colors.white,
                      context,
                      const Icon(Icons.meeting_room_outlined,
                          color: Colors.blue),
                      "ห้อง", () {
                    itemInBody = 2;
                    setState(() {});
                    Navigator.pop(context);
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Myproduct(),));
                  }),
                  itemInDrawer(
                      color: itemInBody == 3 ? Colors.blue[200] : Colors.white,
                      context,
                      const Icon(Icons.border_all, color: Colors.blue),
                      "รอบการแสดง", () {
                    itemInBody = 3;
                    setState(() {});
                    Navigator.pop(context);
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Myproduct(),));
                  }),
                ]),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Divider(height: 3, color: Colors.black54),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      itemInDrawer(
                          context,
                          Icon(
                            Icons.output_outlined,
                            color: Colors.blue[700],
                          ),
                          "ออกจากระบบ", () {
                        ref.read(loginProvider.notifier).logOut();
                        //  ref.read(sessionProvider.notifier).delete();
                      })
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
