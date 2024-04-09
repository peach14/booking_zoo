import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomRadio extends ConsumerStatefulWidget {
  const CustomRadio({
    Key? key,
    this.ontap,
    this.laBle,
    this.index,
    this.isSelected,
  }) : super(key: key);
  final void Function()? ontap;
  final String? laBle;
  final int? index;
  final bool? isSelected;
  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends ConsumerState<CustomRadio> {
  bool isSelect = false;

  @override
  void initState() {
    isSelect = widget.isSelected ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        //    initialValue: inputDataController.isSelectSex,
        validator: (value) {
          if (value == null) {
            return 'กรุณาระบุ';
          }
          return null;
        },
        builder: (FormFieldState<dynamic> field) {
          return Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      widget.ontap?.call();
                      setState(() {
                        isSelect = !isSelect;
                      });
                    },
                    child: Container(
                        width:
                            16, // Adjust the size of the radio button as needed
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelect == true
                                ? Colors.blue
                                : Colors.grey, // Border color when not selected
                            width: isSelect == true ? 4.0 : 2.0,
                          ),
                          color: Colors.transparent, // Selected color
                        ),
                        child: Center(
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                        // Hide the center circle when not selected
                        ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      widget.laBle ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              if (field.errorText != null)
                const Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    "กรุณาระบุ",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          );
        });
  }
}
