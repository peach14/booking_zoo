import 'package:booking_zoo/constants/asset/asset_phat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared_components/form_email.dart';
import '../../animal/controller/show_animal_controller.dart';
import '../../room_animal/controller/show_room_controller.dart';
import '../../round_booking/controller/show_round_controller.dart';
import '../component/button_login.dart';
import '../controler/login_controller.dart';

class Login extends ConsumerStatefulWidget {
  const Login({
    super.key,
  });

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePhat.backgroundLogin3),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
              Colors.black12,
              Colors.black12,
            ])),
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    if (ref.watch(showRoundProvider).isEmpty &&
                        ref.watch(shoAnimalProvider).isEmpty &&
                        ref.watch(showRoomProvider).isEmpty)
                      Container(
                        color: Colors.white,
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: const Text(
                            textAlign: TextAlign.center,
                            'ระบบยังไม่มีข้อมูล กรุณาเข้า"admin"เพื่อสร้างข้อมูล',
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: TextStyle(fontSize: 20)),
                      ),
                    Text(
                      "ZOO CITY",
                      style: GoogleFonts.zenTokyoZoo(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          shadows: [
                            const BoxShadow(
                              color: Colors.black,
                              offset: Offset(
                                1.0,
                                1.0,
                              ),
                              blurRadius: 20.0,
                              spreadRadius: 20.0,
                            )
                          ],
                          fontSize:
                              MediaQuery.of(context).size.shortestSide * 0.13),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.02),
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.1,
                      ),
                      width: MediaQuery.of(context).size.width * 0.69,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(
                                1.0,
                                1.0,
                              ),
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                            ), //
                          ],
                          color: Colors.white30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                FormEmail(
                                  filed: 'email',
                                  icon: const Icon(Icons.mail_outline),
                                  controller: controllerUsername,
                                  textErr: 'กรุณาระบุ username ของท่าน',
                                  hintText: 'for admin required "admin"',
                                ),
                                FormEmail(
                                  filed: 'pass',
                                  icon: const Icon(Icons.password),
                                  controller: controllerPass,
                                  textErr: 'กรุณากรอกรหัสผ่าน 1234',
                                  hintText: '1234',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.035,
                          ),
                          ButtonLogin(
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                ref.read(loginProvider.notifier).validator(
                                    username: controllerUsername.text,
                                    pass: controllerPass.text);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
