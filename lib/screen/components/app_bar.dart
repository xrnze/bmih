import 'package:flutter/material.dart';

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HistoryAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      title: const Text(
        "Histori",
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: const Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Tanggal",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Tinggi (cm)",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Berat (kg)",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Jenis kelamin",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Expanded(
                child: Text(
                  "Hasil",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
