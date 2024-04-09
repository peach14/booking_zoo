import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading extends StatefulWidget {
  final double height;
  final Color color;
  final double loadingSize;

  const Loading(
      {Key? key,
      this.height = 110,
      this.color = Colors.white,
      this.loadingSize = 30})
      : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  AnimationController? animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    animation =
        Tween<double>(begin: 0, end: 2 * pi).animate(animationController!);

    animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController!.reset();
        animationController!.forward();
      }
    });

    animationController!.forward();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      child: SizedBox(
        height: 190,
        width: 190,
        child: CircularText(
            radius: 60,
            //  backgroundPaint: Paint()..color = Colors.pink,
            children: [
              TextItem(
                  text: Text(
                "Zoo CITY",
                style: GoogleFonts.zenTokyoZoo(
                  color: Colors.amber,
                  shadows: [
                    const BoxShadow(
                      color: Colors.amber,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 20.0,
                      spreadRadius: 20.0,
                    )
                  ],
                ),
              ))
            ]),
      ),
      builder: (context, child) {
        return RotationTransition(
          turns: Tween<double>(begin: 0, end: 1).animate(animationController!),
          child: child,
        );
      },
    );
  }
}
