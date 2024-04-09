import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/manage_time.dart';
import '../controller/create_round_controller.dart';

class Round extends ConsumerStatefulWidget {
  const Round({super.key});

  @override
  ConsumerState<Round> createState() => _RoundState();
}

class _RoundState extends ConsumerState<Round> with TickerProviderStateMixin {
  Container tap({required int index}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.amber,
      ),
      width: double.infinity,
      child: Tab(
        text: 'รอบ $index',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final round = ref.watch(roundProvider);

    TabController tabController = TabController(
        length: round.maybeWhen(
          orElse: () => 0,
          data: (data) => data.length,
        ),
        vsync: this);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            round.when(
              data: (data) {
                List<Widget> tapcom = [];
                List<Widget> bodyTap = [];
                for (int i = 0;
                    i <
                        round.maybeWhen(
                          orElse: () => 0,
                          data: (data) => data.length,
                        );
                    i++) {
                  tapcom.add(tap(index: i + 1));
                  bodyTap.add(ManageTime(
                    mainIndex: i,
                    addData: data[i].one,
                  ));
                }
                if (data.isEmpty) {
                  return const Center(
                    child: Text("ยังไม่มีข้อมูล"),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        TabBar(
                          indicatorWeight: 7,
                          controller: tabController,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.white,
                          indicatorColor: const Color.fromARGB(255, 4, 204, 17),
                          //     dividerColor: Colors.transparent,
                          tabs: tapcom,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height * 0.78378,
                          child: TabBarView(
                              controller: tabController, children: bodyTap),
                        ),
                      ],
                    ),
                  );
                }
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
