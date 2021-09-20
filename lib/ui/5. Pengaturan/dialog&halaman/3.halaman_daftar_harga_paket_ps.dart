import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/api/3.api_daftar_harga_paket_ps.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class HalamanDaftarHargaPaketPS extends StatefulWidget {
  const HalamanDaftarHargaPaketPS({Key? key}) : super(key: key);

  @override
  _HalamanDaftarHargaPaketPSState createState() => _HalamanDaftarHargaPaketPSState();
}

class _HalamanDaftarHargaPaketPSState extends State<HalamanDaftarHargaPaketPS> {
  late LinkedScrollControllerGroup tablelinkedScrollController = LinkedScrollControllerGroup();
  ScrollController tableScrollController1 = ScrollController();
  ScrollController tableScrollController2 = ScrollController();

  TextEditingController namaTarif = TextEditingController();
  TextEditingController biayaAwal = TextEditingController();
  TextEditingController durasiAwal = TextEditingController();
  TextEditingController biayaSelanjutnya = TextEditingController();
  TextEditingController durasiSelanjutnya = TextEditingController();
  TextEditingController biayaPerJam = TextEditingController();
  String namaTarifString = "";
  String biayaAwalString = "";
  String durasiAwalString = "";
  String biayaSelanjutnyaString = "";
  String durasiSelanjutnyaString = "";
  String biayaPerJamString = "";

  List<String> listjenisTarif = ["personal", "paket", "member", "custom"];
  String stringListJenisTarif = "personal";
  late StateSetter _stateSetterJenisTarif;

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }
    return string[0].toUpperCase() + string.substring(1);
  }

  void actionJenisTarifListener(String value) {
    setState(() {
      stringListJenisTarif = value;
    });
  }

  void dialogJenisTarif({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (_) {
        String indexStringListJenisTarif = stringListJenisTarif;
        return StatefulBuilder(builder: (BuildContext __, StateSetter setter) {
          _stateSetterJenisTarif = setter;
          return AlertDialog(
            title: Text("Jenis Tarif"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: listjenisTarif
                  .map(
                    (e) => RadioListTile(
                      value: e,
                      groupValue: indexStringListJenisTarif,
                      title: Text(capitalize("$e")),
                      onChanged: (dynamic value) {
                        _stateSetterJenisTarif(() {
                          indexStringListJenisTarif = value;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(__);
                },
                child: Text("CANCEL"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(__);
                  actionJenisTarifListener(indexStringListJenisTarif);
                },
                child: Text("OKAY"),
              ),
            ],
          );
        });
      },
    );
  }

  List<String> listJenisPS = ["PS3", "PS4", "PS5"];
  String stringListJenisPS = "";
  late StateSetter _stateSetterJenisPS;

  void actionJenisPSListener(String index) {
    setState(() {
      stringListJenisPS = index;
    });
  }

  void dialogJenisPS({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (_) {
        String indexStringListJenisPS = stringListJenisPS;
        return StatefulBuilder(builder: (BuildContext __, StateSetter setter) {
          _stateSetterJenisPS = setter;
          return AlertDialog(
            title: Text("Jenis PS"),
            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: listJenisPS
                  .map(
                    (e) => RadioListTile(
                      value: e,
                      groupValue: indexStringListJenisPS,
                      title: Text("$e"),
                      onChanged: (dynamic value) {
                        _stateSetterJenisPS(() {
                          indexStringListJenisPS = value;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(__);
                  actionJenisPSListener(indexStringListJenisPS);
                },
                child: Text("OKAY"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(__);
                },
                child: Text("CANCEL"),
              ),
            ],
          );
        });
      },
    );
  }

  void resetAllFormValue() {
    setState(() {
      page = 0;
      stringListJenisPS = "";
      stringListJenisTarif = "personal";
      namaTarif.text = "";
      biayaAwal.text = "";
      durasiAwal.text = "";
      biayaSelanjutnya.text = "";
      durasiSelanjutnya.text = "";
      biayaPerJam.text = "";
      namaTarifString = "";
      biayaAwalString = "";
      durasiAwalString = "";
      biayaSelanjutnyaString = "";
      durasiSelanjutnyaString = "";
      biayaPerJamString = "";
    });
  }

  int page = 0;
  int initEditState = 0;
  int indexListDataTable = -1;
  List listDataTable = [];

  Future<void> loadDataTable() async {
    setState(() {
      listDataTable = [];
    });
    await ApiDaftarHargaPaketPS.infoAllPaketPS().then((value) {
      setState(() {
        listDataTable = jsonDecode(value.body);
      });
    });
  }

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
    return WillPopScope(
      onWillPop: () async {
        if (page == 0) {
          return true;
        } else {
          resetAllFormValue();
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: page == 0
              ? Text("Harga Paket PS")
              : page == 1
                  ? Text("Tambah Paket PS")
                  : Text("Edit Paket PS"),
          brightness: Brightness.dark,
          actions: [
            page == 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        primary: Colors.white,
                        side: BorderSide(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          page = 1;
                        });
                      },
                      icon: Icon(Icons.add),
                      label: Text("TAMBAH"),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        body: page == 0 ? halamanAwal(context) : halamanTambahEditPaket(),
      ),
    );
  }

  Widget halamanAwal(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 60,
            child: Row(
              children: [
                Material(
                    elevation: 2,
                    color: Colors.blue,
                    child: Container(width: lebar * 0.125, child: Center(child: Text("No.", style: TextStyle(color: Colors.white))))),
                Expanded(
                    child: SingleChildScrollView(
                  controller: tableScrollController1,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: lebar * 0.275, child: Text("Nama Paket", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.275, child: Text("Jenis Tarif", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.125, child: Text("paket", style: TextStyle(color: Colors.white))),
                      Container(width: lebar * 0.150, child: Text("Jenis PS", style: TextStyle(color: Colors.white))),
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
                        elevation: 2,
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
                                Container(width: lebar * 0.275, child: Text(e1["namapaket"])),
                                Container(width: lebar * 0.275, child: Text(capitalize(e1["jenistarif"]))),
                                Container(width: lebar * 0.125, child: Text(e1["package"].toString())),
                                Container(width: lebar * 0.150, child: Text(e1["jenisps"])),
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
                                              page = 2;
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
                                                content: Text("Apakah anda yakin untuk menghapus data Aset PS pada meja ${e1["no_ps"]} ?"),
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
                                                            ApiDaftarHargaPaketPS.hapusPaketPS(map: {"idpaket": e1["idpaket"]}).then((value) {
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget halamanTambahEditPaket() {
    if (page == 2 && initEditState == 0) {
      setState(() {
        namaTarif = TextEditingController(text: listDataTable[indexListDataTable]["namapaket"]);
        biayaAwal = TextEditingController(text: listDataTable[indexListDataTable]["costawal"].toString());
        durasiAwal = TextEditingController(text: listDataTable[indexListDataTable]["durasiawal"].toString());
        biayaSelanjutnya = TextEditingController(text: listDataTable[indexListDataTable]["costnext"].toString());
        durasiSelanjutnya = TextEditingController(text: listDataTable[indexListDataTable]["durasinext"].toString());
        biayaPerJam = TextEditingController(text: listDataTable[indexListDataTable]["costawal"].toString());
        namaTarifString = listDataTable[indexListDataTable]["namapaket"];
        biayaAwalString = listDataTable[indexListDataTable]["costawal"].toString();
        durasiAwalString = listDataTable[indexListDataTable]["durasiawal"].toString();
        biayaSelanjutnyaString = listDataTable[indexListDataTable]["costnext"].toString();
        durasiSelanjutnyaString = listDataTable[indexListDataTable]["durasinext"].toString();
        biayaPerJamString = listDataTable[indexListDataTable]["costawal"].toString();
        initEditState = 1;
      });
    }
    bool isButtonActive() {
      if (stringListJenisTarif == "personal") {
        return namaTarifString == "" && biayaAwalString == "" && durasiAwalString == "" && biayaSelanjutnyaString == "" && durasiSelanjutnyaString == ""  && stringListJenisPS == ""||
                namaTarifString == "" ||
                biayaAwalString == "" ||
                durasiAwalString == "" ||
                biayaSelanjutnyaString == "" ||
                durasiSelanjutnyaString == "" ||
                stringListJenisPS == ""
            ? false
            : true;
      } else if (stringListJenisTarif == "paket") {
        return namaTarifString == "" && biayaAwalString == "" || namaTarifString == "" || biayaAwalString == "" ? false : true;
      } else if (stringListJenisTarif == "member" || stringListJenisTarif == "custom") {
        return namaTarifString == "" && biayaPerJamString == "" || namaTarifString == "" || biayaPerJamString == "" ? false : true;
      } else {
        return false;
      }
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  elevation: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4625,
                    child: ListTile(
                      leading: Icon(Icons.sort),
                      title: Text("Jenis Tarif"),
                      subtitle: Text(capitalize("$stringListJenisTarif"), overflow: TextOverflow.ellipsis),
                      onTap: () {
                        dialogJenisTarif(context: context);
                      },
                    ),
                  ),
                ),
                Material(
                  elevation: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4625,
                    child: ListTile(
                      leading: Icon(Icons.sort),
                      title: Text("Jenis PS"),
                      subtitle: Text("$stringListJenisPS", overflow: TextOverflow.ellipsis),
                      onTap: () {
                        dialogJenisPS(context: context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                capitalize("$stringListJenisTarif"),
                style: TextStyle(fontSize: 24, color: Colors.blue),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text("Nama Tarif", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: namaTarif,
                  decoration: InputDecoration(hintText: "Nama Tarif"),
                  onChanged: (_) {
                    setState(() {
                      namaTarifString = _;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                stringListJenisTarif == "personal" || stringListJenisTarif == "paket"
                    ? Container(
                        width: stringListJenisTarif == "personal" ? MediaQuery.of(context).size.width * 0.4625 : MediaQuery.of(context).size.width - 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Text("Biaya Awal", style: TextStyle(fontSize: 16)),
                            TextFormField(
                              controller: biayaAwal,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: "0"),
                              onChanged: (_) {
                                setState(() {
                                  biayaAwalString = _;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                stringListJenisTarif == "personal"
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.4625,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Text("Durasi Awal", style: TextStyle(fontSize: 16)),
                            TextFormField(
                              controller: durasiAwal,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: "0"),
                              onChanged: (_) {
                                setState(() {
                                  durasiAwalString = _;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            stringListJenisTarif == "personal"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4625,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Text("Biaya Selanjutnya", style: TextStyle(fontSize: 16)),
                            TextFormField(
                              controller: biayaSelanjutnya,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: "0"),
                              onChanged: (_) {
                                setState(() {
                                  biayaSelanjutnyaString = _;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4625,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Text("Durasi Selanjutnya", style: TextStyle(fontSize: 16)),
                            TextFormField(
                              controller: durasiSelanjutnya,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: "0"),
                              onChanged: (_) {
                                setState(() {
                                  durasiSelanjutnyaString = _;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            stringListJenisTarif == "paket"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text("Durasi", style: TextStyle(fontSize: 16)),
                          Text(" *dalam menit", style: TextStyle(fontSize: 16, color: Colors.red)),
                        ],
                      ),
                      TextFormField(
                        controller: durasiAwal,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "0"),
                        onChanged: (_) {
                          setState(() {
                            durasiAwalString = _;
                          });
                        },
                      ),
                    ],
                  )
                : SizedBox(),
            stringListJenisTarif == "member" || stringListJenisTarif == "custom"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text("Biaya per jam", style: TextStyle(fontSize: 16)),
                      TextFormField(
                        controller: biayaPerJam,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "0"),
                        onChanged: (_) {
                          setState(() {
                            biayaPerJamString = _;
                          });
                        },
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 24),
            FractionallySizedBox(
              widthFactor: 1,
              child: TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                onPressed: isButtonActive()
                    ? () {
                        Map<String, dynamic> map = {
                          "idpaket": page == 1 ? "" : listDataTable[indexListDataTable]["idpaket"],
                          "namapaket": namaTarif.text,
                          "jenisps": stringListJenisPS,
                          "jenistarif": stringListJenisTarif,
                          "package": stringListJenisTarif == "personal" ? "0" : "1",
                          "costawal": biayaAwal.text,
                          "durasiawal": stringListJenisTarif == "personal" || stringListJenisTarif == "paket" ? durasiAwal.text : "0",
                          "costnext": stringListJenisTarif == "personal" ? biayaSelanjutnya.text : "0",
                          "durasinext": stringListJenisTarif == "personal" ? durasiSelanjutnya.text : "0",
                          "secondscounter": stringListJenisTarif == "personal" || stringListJenisTarif == "paket" ? durasiAwal.text : "60",
                        };
                        print(map);
                        if (page == 1) {
                          ApiDaftarHargaPaketPS.addPaketPS(map: map).then((value) {
                            resetAllFormValue();
                            loadDataTable();
                          });
                        } else {
                          ApiDaftarHargaPaketPS.updatePaketPS(map: map).then((value) {
                            resetAllFormValue();
                            loadDataTable();
                          });
                        }
                      }
                    : null,
                icon: Icon(page == 1 ? Icons.add : Icons.save),
                label: Text(page == 1 ? "TAMBAH PAKET HARGA" : "UPDATE PAKET HARGA"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
