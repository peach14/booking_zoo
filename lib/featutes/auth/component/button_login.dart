import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    super.key,
    required this.onPress,
  });
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 30,
      //  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.0),
      padding: const EdgeInsets.only(right: 5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            //  shape: const StadiumBorder(),
            minimumSize: const Size(110, 40),
            backgroundColor: const Color.fromARGB(255, 78, 164, 11),
          ),
          onPressed: onPress,
          child: const Text("Login")),
    );
  }
}
