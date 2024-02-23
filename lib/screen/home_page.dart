import 'package:bmih/model/bmi.dart';
import 'package:bmih/screen/result_page.dart';
import 'package:bmih/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int height = 0;
  int weight = 0;
  int selectedGender = 1;

  @override
  Widget build(BuildContext context) {
    double genderWidth = MediaQuery.of(context).size.width * 0.42;

    Route createRoute(Calculation payload) {
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

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 1.0, color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                onTap: () {
                  setState(() {
                    selectedGender = 1;
                  });
                },
                child: SizedBox(
                    width: genderWidth,
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ColorFiltered(
                              colorFilter:
                                  selectedGender == 2 ? greyscale : identity,
                              child: Image.asset(
                                'assets/images/male.png',
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ),
                            ),
                            const Text("Laki-laki")
                          ],
                        ))),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 1.0, color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                onTap: () {
                  setState(() {
                    selectedGender = 2;
                  });
                },
                child: SizedBox(
                    width: genderWidth,
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ColorFiltered(
                              colorFilter:
                                  selectedGender == 1 ? greyscale : identity,
                              child: Image.asset(
                                'assets/images/female.png',
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ),
                            ),
                            const Text("Perempuan")
                          ],
                        ))),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 120, // <-- TextField height
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                    maxLines: null,
                    expands: false,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        errorMaxLines: 2,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Tinggi Badan (dalam cm)'),
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _formKey.currentState!.validate();
                        setState(() {
                          height = int.parse(value);
                        });
                      }
                    },
                    validator: (value) {
                      if ((value?.length ?? 0) < 3 ||
                          (value?[0] ?? "") == "0") {
                        return "Silakan isi dengan angka minimal 3 digit, angka pertama tidak boleh 0";
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 120,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                    maxLines: null,
                    expands: false,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Berat Badan (dalam kg)',
                        errorMaxLines: 2),
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          _formKey.currentState!.validate();
                          weight = int.parse(value);
                        }
                      });
                    },
                    validator: (value) {
                      if ((value?.length ?? 0) < 2 ||
                          (value?[0] ?? "") == "0") {
                        return "Silakan isi dengan angka minimal 2 digit, angka pertama tidak boleh 0";
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onPressed: height > 0 && weight > 0
                        ? () {
                            {
                              if (_formKey.currentState!.validate()) {
                                double result = weight /
                                    ((height * 0.01) * (height * 0.01));
                                debugPrint("result: $result");
                                Navigator.of(context).push(createRoute(
                                    Calculation(
                                        id: "",
                                        height: height,
                                        weight: weight,
                                        gender: selectedGender,
                                        date: DateTime.now()
                                            .toLocal()
                                            .millisecondsSinceEpoch,
                                        result: result)));
                              }
                            }
                          }
                        : null,
                    child: Text(
                      "Hitung",
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.fontSize),
                    ))
              ],
            )),
      ],
    );
  }
}
