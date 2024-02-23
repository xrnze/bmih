import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BmiBar extends StatelessWidget {
  const BmiBar({Key? key, this.result, this.gender}) : super(key: key);

  final double? result;
  final int? gender;

  List<RangeLinearGauge> linearGauge(int gender) {
    print(result);
    if (gender == 2) {
      return [
        RangeLinearGauge(
            color: Color.fromARGB(255, 196, 177, 0), start: 10, end: 18),
        RangeLinearGauge(color: Colors.green, start: 18, end: 25),
        RangeLinearGauge(color: Colors.orange, start: 25, end: 27),
        RangeLinearGauge(color: Colors.red, start: 27, end: 35),
      ];
    }
    return [
      RangeLinearGauge(
          color: Color.fromARGB(255, 196, 177, 0), start: 10, end: 17),
      RangeLinearGauge(color: Colors.green, start: 17, end: 23),
      RangeLinearGauge(color: Colors.orange, start: 23, end: 27),
      RangeLinearGauge(color: Colors.red, start: 27, end: 35),
    ];
  }

  List<CustomRulerLabel> label(int gender) {
    if (gender == 2) {
      return const [
        CustomRulerLabel(text: "", value: 10),
        CustomRulerLabel(text: "Kurus", value: 14),
        CustomRulerLabel(text: "Ideal", value: 21.5),
        CustomRulerLabel(text: "Gemuk", value: 26),
        CustomRulerLabel(text: "Obesitas", value: 31),
        CustomRulerLabel(text: "", value: 35),
      ];
    }

    return const [
      CustomRulerLabel(text: "", value: 10),
      CustomRulerLabel(text: "Kurus", value: 13.5),
      CustomRulerLabel(text: "Ideal", value: 20),
      CustomRulerLabel(text: "Gemuk", value: 25),
      CustomRulerLabel(text: "Obesitas", value: 31),
      CustomRulerLabel(text: "", value: 35),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 320,
        child: LinearGauge(
            rangeLinearGauge: linearGauge(gender ?? 0),
            start: 0,
            end: 50,
            customLabels: label(gender ?? 0),
            pointers: [
              Pointer(
                value: result ?? 0,
                shape: PointerShape.triangle,
                pointerPosition: PointerPosition.top,
              )
            ],
            rulers: RulerStyle(
                rulerPosition: RulerPosition.bottom,
                showPrimaryRulers: false,
                showSecondaryRulers: false)));
  }
}
