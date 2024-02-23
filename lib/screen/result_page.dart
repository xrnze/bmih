import 'package:bmih/model/bmi.dart';
import 'package:bmih/screen/components/bmi_bar.dart';
import 'package:bmih/screen/components/result_text.dart';
import 'package:bmih/services/db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/v4.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, this.payload}) : super(key: key);

  final Calculation? payload;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final DatabaseService _databaseService = DatabaseService();
  bool exist = false;

  @override
  void initState() {
    super.initState();

    exist = widget.payload?.id.isNotEmpty ?? false;
  }

  Future<void> onSaveResult() async {
    try {
      widget.payload?.id = const UuidV4().generate();
      await _databaseService.save(widget.payload ??
          Calculation(
              id: "",
              height: 0,
              weight: 0,
              gender: 0,
              date: DateTime.now().toLocal().millisecondsSinceEpoch,
              result: 0));
      setState(() {
        exist = true;
      });
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gagal menyimpan hasil BMI")));
      }
    }
  }

  Future<void> onDelete(BuildContext context) async {
    try {
      await _databaseService.deleteResult(widget.payload?.id ?? "");
      setState(() {
        exist = false;
      });
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  double barValue(double result) {
    print(result);
    if (result < 10) {
      return 10;
    } else if (result > 35) {
      return 35;
    }

    return result;
  }

  String resultTextMale(double result) {
    switch (result) {
      case (< 17):
        return "Berat Badan Kurang";
      case (>= 17 && <= 23):
        return "Berat Badan Ideal";
      case (>= 23 && <= 27):
        return "Berat Badan Lebih";
      case > 27:
        return "Obesitas";
      default:
        return "";
    }
  }

  String resultTextFemale(double result) {
    switch (result) {
      case (< 18):
        return "Berat Badan Kurang";

      case (>= 18 && <= 25):
        return "Berat Badan Ideal";

      case (>= 25 && <= 27):
        return "Berat Badan Lebih";

      case (> 27):
        return "Obesitas";

      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hasil"),
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 1.0, color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),
                  child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "BMI untuk ${Gender[widget.payload?.gender]}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                (widget.payload?.gender ?? 0) == 1
                                    ? resultTextMale(
                                        widget.payload?.result ?? 0)
                                    : resultTextFemale(
                                        widget.payload?.result ?? 0),
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.payload?.result.toStringAsFixed(1) ??
                                    '0',
                                style: const TextStyle(
                                    fontSize: 70,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text("Tinggi Badan (cm)"),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.payload?.height.toString() ??
                                              "0",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Berat Badan (kg)"),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.payload?.weight.toString() ??
                                              "0",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BmiBar(
                                result: barValue(widget.payload?.result ?? 0),
                                gender: widget.payload?.gender ?? 0,
                              )
                            ],
                          )))),
              const SizedBox(
                height: 20,
              ),
              ResultText(
                  result: widget.payload?.result ?? 0,
                  gender: widget.payload?.gender ?? 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        if (exist) {
                          onDelete(context);
                        } else {
                          onSaveResult();
                        }
                      },
                      icon: Icon(
                          exist ? Icons.bookmark : Icons.bookmark_outline)),
                ],
              )
            ],
          ),
        ));
  }
}
