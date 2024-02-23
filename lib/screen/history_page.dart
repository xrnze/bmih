import 'package:bmih/model/bmi.dart';
import 'package:bmih/screen/result_page.dart';
import 'package:bmih/services/db.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DatabaseService _databaseService = DatabaseService();

  Route createRoute(Calculation? payload) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ResultPage(
        payload: payload,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Calculation>>(
      future: _databaseService.savedResults(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if ((snapshot.data?.length ?? 0) < 1) {
          print(snapshot.data);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/no_data_2.jpg',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Tidak ada data yang disimpan",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(createRoute(snapshot.data?[index]))
                      .then((value) => setState(() {}));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        // width: 70,
                        child: Text(
                          DateFormat('dd/MM/yy').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  snapshot.data?[index].date ?? 0)),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        // width: 90,
                        child: Text(
                          (snapshot.data?[index].height ?? 0).toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        // width: 80,
                        flex: 2,
                        child: Text(
                          (snapshot.data?[index].weight ?? 0).toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        // width: 100,
                        flex: 2,
                        child: Text(
                          Gender[snapshot.data?[index].gender ?? 0] ?? "",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        // flex: 0,
                        child: Text(
                          (snapshot.data?[index].result ?? 0)
                              .toStringAsFixed(1),
                          style: const TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ));
          },
          separatorBuilder: (BuildContext context, int index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                indent: 0,
                endIndent: 0,
                height: 0,
              )),
        );
      },
    );
  }
}
