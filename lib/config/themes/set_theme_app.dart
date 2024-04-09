import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routing/route.dart';

final navigatorState = GlobalKey<NavigatorState>();

class SetThemesApp extends ConsumerWidget {
  const SetThemesApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: const Locale('th'),
        routerConfig: appRouter,
        themeMode: ThemeMode.system,
        theme: ThemeData.from(colorScheme: const ColorScheme.light()).copyWith(
            textTheme: GoogleFonts.promptTextTheme(),
            appBarTheme: const AppBarTheme(color: Colors.blueAccent),
            //  textButtonTheme: TextButtonThemeData(style: ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith(
                      (states) => const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          side: BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(255, 33, 87, 0),
                          )),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) => Colors.deepOrangeAccent[200],
                    )))));
  }
}
