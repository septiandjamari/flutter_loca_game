import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/3.%20Member/halaman_claim_hadiah.dart';
import 'package:flutter_loca_game/ui/3.%20Member/halaman_tambah_edit_member.dart';

class HalamanUtamaMember extends StatefulWidget {
  const HalamanUtamaMember({Key? key}) : super(key: key);

  @override
  _HalamanUtamaMemberState createState() => _HalamanUtamaMemberState();
}

class _HalamanUtamaMemberState extends State<HalamanUtamaMember> {
  void dialogKonfirmHapus(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text("Konfirmasi"),
            content: Text("Yakin Menghapus member ID $index?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("CANCEL")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OKAY")),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
