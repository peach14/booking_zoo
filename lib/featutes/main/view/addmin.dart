import 'package:booking_zoo/constants/asset/asset_phat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Utils/UI/cs_buttom_sheet.dart';
import '../../../shared_components/form_email.dart';
import '../../animal/views/create_annimal_screen.dart';
import '../../auth/controler/login_controller.dart';
import '../../room_animal/controller/create_room_controller.dart';
import '../../room_animal/views/list_room.dart';
import '../../round_booking/controller/create_round_controller.dart';
import '../../round_booking/views/manage_round.dart';
import '../../scanner/view/scanner.dart';
import '../controller/provider.dart';

class AddMinScreen extends ConsumerStatefulWidget {
  const AddMinScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddMinScreen> createState() => _AddMinScreenState();
}

class _AddMinScreenState extends ConsumerState<AddMinScreen> {
  int itemInBody = 1;
  TextEditingController monny = TextEditingController();
  TextEditingController chair = TextEditingController();
  TextEditingController name = TextEditingController(text: 'room');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: buildDrawer(context),
            appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 49, 208, 78),
                actions: [
                  itemInBody == 1
                      ? IconButton(
                          onPressed: () {
                            CusButTomSheet().sheet(
                              context: context,
                              createRadio: true,
                              ok: () {
                                ref.read(roomProvider.notifier).createRoom(
                                    name: name.text,
                                    seat: chair.text,
                                    price: monny.text,
                                    context: context,
                                    type: []);

                                Navigator.pop(context);
                                monny.clear();
                                chair.clear();
                                name.clear();
                              },
                              title: 'เพิ่มห้องใหม่',
                              textFiled_1: FormEmail(
                                icon: const Icon(Icons.paste),
                                controller: name,
                                textErr: 'กรุณากรอกชื่อ',
                                hintText: 'ชื่อห้อง',
                              ),
                              textFiled_3: FormEmail(
                                icon: const Icon(Icons.chair_alt_sharp),
                                controller: chair,
                                textErr: 'กรุณากรอกจำนวนที่นั่ง',
                                hintText: '0',
                              ),
                              textFiled_2: FormEmail(
                                icon: const Icon(Icons.monetization_on),
                                controller: monny,
                                textErr: 'กรุณากรอกราคา',
                                hintText: '0',
                              ),
                            );
                          },
                          icon: const Icon(Icons.add))
                      : const SizedBox(),
                  if (itemInBody == 2)
                    IconButton(
                        onPressed: () async {
                          ref.read(roundProvider.notifier).addRound();
                        },
                        icon: const Icon(Icons.add_card)),
                  if (itemInBody == 2)
                    IconButton(
                        onPressed: () async {
                          ref.read(roundProvider.notifier).deleteRound();
                        },
                        icon: const Icon(Icons.folder_delete_rounded))
                ],
                title: Text(itemInBody == 1
                    ? "จัดการห้อง"
                    : itemInBody == 2
                        ? "จัดการรอบโชว์"
                        : itemInBody == 3
                            ? "จัดการข้อมูลสัต"
                            : itemInBody == 4
                                ? "สแกน QR"
                                : 'ไม่มีข้อมูล')),
            body: itemInBody == 1
                ? const ListRoom()
                : itemInBody == 2
                    ? const Round()
                    : itemInBody == 3
                        ? const MagAnimal()
                        : itemInBody == 4
                            ? const Scanner()
                            : const Text("ไม่มีข้อมูล")));
  }

  Container itemInDrawer(
      BuildContext context, Icon fIcon, String name, VoidCallback onTap,
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
            ),
          ),
          onPressed: onTap,
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
    final data = ref.watch(dataAdmin);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePhat.zebra,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(data.value ?? 'noData')
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
                      const Icon(Icons.meeting_room_outlined,
                          color: Colors.blue),
                      "จัดการห้อง", () {
                    itemInBody = 1;
                    setState(() {});
                    Navigator.pop(context);
                  }),
                  itemInDrawer(
                      color: itemInBody == 2 ? Colors.blue[200] : Colors.white,
                      context,
                      const Icon(Icons.border_all, color: Colors.blue),
                      "จัดการรอบโชว์", () {
                    itemInBody = 2;
                    setState(() {});
                    Navigator.pop(context);
                  }),
                  itemInDrawer(
                      color: itemInBody == 3 ? Colors.blue[200] : Colors.white,
                      context,
                      const Icon(Icons.android_sharp, color: Colors.blue),
                      "จัดการข้อมูลสัต", () {
                    itemInBody = 3;
                    setState(() {});
                    Navigator.pop(context);
                  }),
                  itemInDrawer(
                    color: itemInBody == 4 ? Colors.blue[200] : Colors.white,
                    context,
                    const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.blue,
                    ),
                    "สแกน QR",
                    () {
                      itemInBody = 4;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ]),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
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
