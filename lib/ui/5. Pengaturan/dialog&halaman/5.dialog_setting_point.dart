import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/api/5.api_setting_point.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class DialogSettingPoint extends StatefulWidget {
  const DialogSettingPoint({Key? key}) : super(key: key);

  @override
  _DialogSettingPointState createState() => _DialogSettingPointState();
}

class _DialogSettingPointState extends State<DialogSettingPoint> {
  late LinkedScrollControllerGroup tablelinkedScrollController = LinkedScrollControllerGroup();
  ScrollController tableScrollController1 = ScrollController();
  ScrollController tableScrollController2 = ScrollController();

  List listDataTable = [];
  int indexListDataTable = -1;

  TextEditingController nilaiDeposit = TextEditingController();
  String nilaiDepositString = "";
  bool nilaiDepositEnabled = true;

  TextEditingController namaHadiah = TextEditingController();
  TextEditingController jumlahPoint = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  String namaHadiahString = "";
  String jumlahPointString = "";
  String keteranganString = "";

  Future<void> loadDataTable() async {
    setState(() {
      listDataTable = [];
    });
    await ApiSettingPoint.getPointHadiah().then((value) async {
      await ApiSettingPoint.getInfoDepositPerPoint().then((value1) {
        setState(() {
          listDataTable = jsonDecode(value.body);
          nilaiDeposit.text = jsonDecode(value1.body)["depositperpoint"].toString();
          nilaiDepositString = jsonDecode(value1.body)["depositperpoint"].toString();
        });
      });
    });
  }

  Future<void> setNilaiDeposit() async {
    setState(() {
      nilaiDepositEnabled = false;
    });
    await ApiSettingPoint.setDepositPerPoint({"value": nilaiDeposit.text}).then((value) async {
      await ApiSettingPoint.getInfoDepositPerPoint().then((value1) {
        setState(() {
          nilaiDeposit.text = jsonDecode(value1.body)["depositperpoint"].toString();
          nilaiDepositEnabled = true;
        });
      });
    });
  }

  void resetAllFormValue() {
    setState(() {
      dialogPage = 0;
      indexListDataTable = -1;
      namaHadiah.text = "";
      jumlahPoint.text = "";
      keterangan.text = "";
      namaHadiahString = "";
      jumlahPointString = "";
      keteranganString = "";
    });
  }

  int dialogPage = 0;
  int initEditState = 0;

  @override
  void initState() {
    super.initState();
    tableScrollController1 = tablelinkedScrollController.addAndGet();
    tableScrollController2 = tablelinkedScrollController.addAndGet();
    loadDataTable();
  }

  @override
  void dispose() {
    tableScrollController1.dispose();
    tableScrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: dialogPage == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Setting Poin"),
                TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                  onPressed: () {
                    setState(() {
                      dialogPage = 1;
                    });
                  },
                  icon: Icon(Icons.add),
                  label: Text("TAMBAH HADIAH"),
                ),
              ],
            )
          : Row(
              children: [
                IconButton(
                  onPressed: () {
                    resetAllFormValue();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 8),
                Text(dialogPage == 1 ? "Tambah Hadiah" : "Update Hadiah"),
              ],
            ),
      insetPadding: EdgeInsets.all(24),
      contentPadding: EdgeInsets.all(12),
      content: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(minHeight: 200, maxHeight: 360),
        child: dialogPage == 0 ? halamanAwal(context) : halamanTambahEdit(),
      ),
      actions: dialogPage == 0
          ? null
          : [
              FractionallySizedBox(
                widthFactor: 1,
                child: TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                  onPressed: namaHadiahString == "" && jumlahPointString == "" && keteranganString == "" ||
                          namaHadiahString == "" ||
                          jumlahPointString == "" ||
                          keteranganString == ""
                      ? null
                      : () {
                          Map<String, dynamic> map = {
                            "idpoint": dialogPage == 1 ? "" : listDataTable[indexListDataTable][""],
                            "namahadiah": namaHadiah.text,
                            "jumlahpoint": jumlahPoint.text,
                            "keterangan": keterangan.text,
                          };
                          dialogPage == 1
                              ? ApiSettingPoint.ngeAddPoint(map).then((value) {
                                  resetAllFormValue();
                                  loadDataTable();
                                })
                              : ApiSettingPoint.ngeditPoint(map).then((value) {
                                  resetAllFormValue();
                                  loadDataTable();
                                });
                        },
                  icon: dialogPage == 1 ? Icon(Icons.add) : Icon(Icons.edit),
                  label: Text(dialogPage == 1 ? "TAMBAH HADIAH" : "UPDATE HADIAH"),
                ),
              )
            ],
    );
  }

  Widget halamanAwal(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Setting nilai deposit setiap point"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  child: TextFormField(
                    controller: nilaiDeposit,
                    enabled: nilaiDepositEnabled,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Masukkan nilai deposit"),
                    onChanged: (_) {
                      setState(() {
                        nilaiDepositString = _;
                      });
                    },
                  ),
                ),
              ),
              TextButton(
                onPressed: nilaiDepositString == ""
                    ? null
                    : () {
                        setNilaiDeposit();
                      },
                child: Text("SAVE"),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            color: Colors.blue,
            height: 60,
            child: Row(
              children: [
                Material(
                    elevation: 4,
                    color: Colors.blue,
                    child: Container(width: lebar * 0.125, child: Center(child: Text("No.", style: TextStyle(color: Colors.white))))),
                Expanded(
                    child: SingleChildScrollView(
                  controller: tableScrollController1,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: lebar * 0.275, child: Text("Nama hadiah", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.275, child: Text("Jumlah point", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.275, child: Text("Keterangan", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.375, child: Center(child: Text("Aksi", style: TextStyle(color: Colors.white)))),
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
                                Container(width: lebar * 0.275, child: Text(e1["namahadiah"])),
                                Container(width: lebar * 0.275, child: Text(e1["jumlahpoint"].toString())),
                                Container(width: lebar * 0.275, child: Text(e1["keterangan"])),
                                Container(
                                  width: lebar * 0.375,
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit, color: Colors.green),
                                          onPressed: () {
                                            setState(() {
                                              dialogPage = 2;
                                              initEditState = 0;
                                              indexListDataTable = index;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete, color: Colors.red),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text("Hapus data Aset PS"),
                                                content: Text("Apakah anda yakin untuk menghapus data user ${e1["username"]} ?"),
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
                                                            Navigator.pop(ctx);
                                                            ApiSettingPoint.ngeDelPoint({
                                                              "iduser": listDataTable[indexListDataTable]["iduser"],
                                                            }).then((value) {
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget halamanTambahEdit() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white10,
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text("Nama Hadiah", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: namaHadiah,
                  decoration: InputDecoration(
                    hintText: "Nama Hadiah",
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text("Jumlah Point", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: jumlahPoint,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Jumlah Point",
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 16),
                Text("Keterangan", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: keterangan,
                  decoration: InputDecoration(
                    hintText: "Keterangan",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
