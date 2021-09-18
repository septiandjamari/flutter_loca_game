import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/3.%20Member/api_member.dart';
import 'package:flutter_loca_game/ui/3.%20Member/halaman_claim_hadiah.dart';
import 'package:flutter_loca_game/ui/3.%20Member/halaman_tambah_edit_member.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class HalamanUtamaMember extends StatefulWidget {
  const HalamanUtamaMember({Key? key}) : super(key: key);

  @override
  _HalamanUtamaMemberState createState() => _HalamanUtamaMemberState();
}

class _HalamanUtamaMemberState extends State<HalamanUtamaMember> {
  late LinkedScrollControllerGroup tablelinkedScrollController = LinkedScrollControllerGroup();
  ScrollController tableScrollController1 = ScrollController();
  ScrollController tableScrollController2 = ScrollController();

  List listDataTable = [];
  Future<void> loadDataTable() async {
    setState(() {
      listDataTable = [];
    });
    await ApiMember.getInfoAllMember().then((value) {
      setState(() {
        listDataTable = jsonDecode(value.body);
      });
    });
  }

  @override
  void dispose() {
    tableScrollController1.dispose();
    tableScrollController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tableScrollController1 = tablelinkedScrollController.addAndGet();
    tableScrollController2 = tablelinkedScrollController.addAndGet();
    loadDataTable();
  }

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
    double lebar = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 60,
            child: Row(
              children: [
                Material(
                    elevation: 4,
                    color: Colors.blue,
                    child: Container(width: lebar * 0.125, child: Center(child: Text("ID.", style: TextStyle(color: Colors.white))))),
                Expanded(
                    child: SingleChildScrollView(
                  controller: tableScrollController1,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: lebar * 0.275, child: Text("User", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.275, child: Text("Jenis PS", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.275, child: Text("Sisa Saldo", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.275, child: Text("Deposit", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.375, child: Text("Masa Aktif", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.200, child: Center(child: Text("Point", style: TextStyle(color: Colors.white)))),
                      Container(width: lebar * 0.425, child: Center(child: Text("Aksi", style: TextStyle(color: Colors.white)))),
                    ],
                  ),
                ))
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: listDataTable.map((e) {
                      int index = listDataTable.indexOf(e) + 1;
                      return Material(
                        elevation: 4,
                        child: Container(
                          color: index % 2 == 0 ? Colors.transparent : Colors.black12,
                          height: 60,
                          child: Row(
                            children: [
                              Container(width: lebar * 0.125, child: Center(child: Text("$index."))),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: tableScrollController2,
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: listDataTable.map((e1) {
                          int index = listDataTable.indexOf(e1);
                          return Container(
                            color: index % 2 != 0 ? Colors.transparent : Colors.black12,
                            height: 60,
                            child: Row(
                              children: [
                                Container(width: lebar * 0.275, child: Text("${e1["username"]}")),
                                Container(width: lebar * 0.275, child: Text("${e1["jenisps"]}")),
                                Container(width: lebar * 0.275, child: Text("Rp.${e1["sisasaldo"]}")),
                                Container(width: lebar * 0.275, child: Text("Rp.${e1["deposit"]}")),
                                Container(
                                    width: lebar * 0.375,
                                    child: Text(DateFormat("HH:mm d MMMM yyyy", "id_ID")
                                        .format(DateTime.fromMillisecondsSinceEpoch(e1["masaaktif"] * 1000))
                                        .toUpperCase())),
                                Container(width: lebar * 0.200, child: Center(child: Text("${e1["point"]}"))),
                                Container(
                                  width: lebar * 0.425,
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit, color: Colors.green),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => HalamanTambahEditMember(addOrEdit: "edit", map: Map<String, dynamic>.from(e1)),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete, color: Colors.red),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text("Hapus Member"),
                                                content: Text("Apakah anda yakin untuk menghapus Member ${e1["username"]} ?"),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(ctx);
                                                          },
                                                          child: Text("CANCEL")),
                                                      TextButton(
                                                          onPressed: () {
                                                            ApiMember.hapusMember({"idmember": e1["idmember"]}).then((value) {
                                                              loadDataTable();
                                                            });
                                                          },
                                                          child: Text("OKAY")),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.card_giftcard, color: Colors.blue),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
