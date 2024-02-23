import 'package:flutter/material.dart';

class ResultText extends StatelessWidget {
  const ResultText({super.key, this.result, this.gender});

  final double? result;
  final int? gender;

  Widget renderTextResult(double result, int gender) {
    if (gender == 2) {
      return renderTextResultFemale(result);
    } else {
      return renderTextResultMale(result);
    }
  }

  Widget renderTextResultMale(double result) {
    switch (result) {
      case (< 17):
        return const Column(
          children: [
            Text(
              "Hasil BMI < 17",
              textAlign: TextAlign.center,
            ),
            Text("Anda berada dalam kategori kekurangan berat badan.",
                textAlign: TextAlign.center),
            Text(
                "Hubungi dokter lebih lanjut mengenai pola makan dan gizi yang baik untuk meningkatkan kesehatan.",
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
          ],
        );
      case (>= 17 && <= 23):
        return const Column(
          children: [
            Text(
              "Hasil BMI diantara 17 dan 23",
              textAlign: TextAlign.center,
            ),
            Text("Anda berada dalam kategori berat badan yang normal.",
                textAlign: TextAlign.center),
            Text(
                "Tetap pertahankan berat badan Anda dan jaga berat badan Anda dengan mengatur keseimbangan antara pola makan dan aktivitas fisik Anda.",
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
          ],
        );
      case (>= 23 && <= 27):
        return const Column(
          children: [
            Text(
              "Hasil BMI diantara 23 dan 27",
              textAlign: TextAlign.center,
            ),
            Text(
                "Anda berada dalam kategori overweight atau berat badan berlebih.",
                textAlign: TextAlign.center),
            Text(
                "Cara terbaik untuk menurunkan berat badan adalah dengan mengatur kalor makanan yang dikonsumsi dan berolahraga.",
                textAlign: TextAlign.center),
            Text(
                "Jika BMI Anda berada dalam kategori ini maka Anda dianjurkan untuk menurunkan berat badan hingga batas normal.",
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
          ],
        );
      case (> 27):
        return const Column(
          children: [
            Text(
              "Hasil BMI lebih dari 27",
              textAlign: TextAlign.center,
            ),
            Text("Anda berada dalam kategori obesitas.",
                textAlign: TextAlign.center),
            Text(
                "Usahakan untuk menurunkan berat badan dan menerapkan pola hidup sehat dengan menjaga makan dan aktivitas fisik.",
                textAlign: TextAlign.center),
            Text(
                "Segera kunjungi dokter untuk dilakukan pemeriksaan kesehatan lanjutan untuk mengetahui risiko yang Anda miliki terkait berat badan Anda.",
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
          ],
        );
      default:
        return Container();
    }
  }

  Widget renderTextResultFemale(double result) {
    switch (result) {
      case (< 18):
        return const Column(
          children: [
            Text(
              "Hasil BMI < 18",
              textAlign: TextAlign.center,
            ),
            Text("Anda berada dalam kategori kekurangan berat badan.",
                textAlign: TextAlign.center),
            Text(
                "Hubungi dokter lebih lanjut mengenai pola makan dan gizi yang baik untuk meningkatkan kesehatan.",
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
          ],
        );
      case (>= 18 && <= 25):
        return const Column(
          children: [
            Text(
              "Hasil BMI diantara 18 dan 25",
              textAlign: TextAlign.center,
            ),
            Text("Anda berada dalam kategori berat badan yang normal.",
                textAlign: TextAlign.center),
            Text(
                "Tetap pertahankan berat badan Anda dan jaga berat badan Anda dengan mengatur keseimbangan antara pola makan dan aktivitas fisik Anda.",
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
          ],
        );
      case (>= 25 && <= 27):
        return const Column(
          children: [
            Text(
              "Hasil BMI diantara 25 dan 27",
              textAlign: TextAlign.center,
            ),
            Text(
                "Anda berada dalam kategori overweight atau berat badan berlebih.",
                textAlign: TextAlign.center),
            Text(
                "Cara terbaik untuk menurunkan berat badan adalah dengan mengatur kalor makanan yang dikonsumsi dan berolahraga.",
                textAlign: TextAlign.center),
            Text(
                "Jika BMI Anda berada dalam kategori ini maka Anda dianjurkan untuk menurunkan berat badan hingga batas normal.",
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
          ],
        );
      case (> 27):
        return const Column(
          children: [
            Text(
              "Hasil BMI lebih dari 27",
              textAlign: TextAlign.center,
            ),
            Text("Anda berada dalam kategori obesitas.",
                textAlign: TextAlign.center),
            Text(
                "Usahakan untuk menurunkan berat badan dan menerapkan pola hidup sehat dengan menjaga makan dan aktivitas fisik.",
                textAlign: TextAlign.center),
            Text(
                "Segera kunjungi dokter untuk dilakukan pemeriksaan kesehatan lanjutan untuk mengetahui risiko yang Anda miliki terkait berat badan Anda.",
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return renderTextResult(result ?? 0, gender ?? 0);
  }
}
