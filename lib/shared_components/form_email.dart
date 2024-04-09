import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passErr = StateProvider<bool>((ref) => false);

class FormEmail extends ConsumerStatefulWidget {
  const FormEmail(
      {Key? key,
      this.filed,
      required this.icon,
      required this.controller,
      this.textErr,
      required this.hintText,
      this.initialValue})
      : super(key: key);
  final Icon icon;
  final TextEditingController controller;
  final String? textErr;
  final String? filed;
  final String hintText;
  final String? initialValue;

  @override
  ConsumerState<FormEmail> createState() => _FormEmailState();
}

class _FormEmailState extends ConsumerState<FormEmail> {
  bool texterr = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: texterr == true || ref.watch(passErr) == true
                    ? const Color.fromARGB(255, 245, 7, 4)
                    : const Color.fromARGB(255, 136, 135, 135),
                width: 1.0),
            color: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(17.0)),
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
          ),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  texterr = true;
                });
              } else if (value.isNotEmpty) {
                setState(() {
                  texterr = false;
                });
              }
              return null;
            },
            autofocus: true,
            initialValue: widget.initialValue,
            cursorColor: Colors.blue[600],
            controller: widget.controller,
            decoration: InputDecoration(
                hintStyle: const TextStyle(
                    textBaseline: TextBaseline.alphabetic, fontSize: 12),
                hintText: widget.hintText,
                prefixIconColor: const Color.fromARGB(255, 78, 164, 11),
                prefixIcon: widget.icon,

                //     suffixIcon: Icon(Icons.mail_outline),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                    top: 12.0, left: 8.0, right: 8.0, bottom: 5.0)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (texterr == true)
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    widget.textErr ?? '',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 245, 7, 4),
                    ),
                    maxLines: 2,
                  )),
            if (widget.filed == 'pass')
              if (texterr != true)
                if (ref.watch(passErr) == true)
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: const Text(
                        'รหัสผ่านไม่ถูก',
                        style: TextStyle(
                          color: Color.fromARGB(255, 245, 7, 4),
                        ),
                        maxLines: 2,
                      ))
          ],
        ),
      ],
    );
  }
}
