import 'package:flutter/material.dart';

import '../component/add_and_delete.dart';

class MagAnimal extends StatefulWidget {
  const MagAnimal({Key? key}) : super(key: key);

  @override
  State<MagAnimal> createState() => _MagAnimalState();
}

class _MagAnimalState extends State<MagAnimal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 4, 204, 17),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.shortestSide * 0.015,
        left: MediaQuery.of(context).size.shortestSide * 0.02,
        right: MediaQuery.of(context).size.shortestSide * 0.02,
      ),
      child: const AddAndDelete(),
    ));
  }
}
