import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/api/1.api_aset_playstation.dart';
import 'package:http/http.dart' as http;
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class DialogAsetPlaystation extends StatefulWidget {
  const DialogAsetPlaystation({Key? key}) : super(key: key);

  @override
  _DialogAsetPlaystationState createState() => _DialogAsetPlaystationState();
}

class _DialogAsetPlaystationState extends State<DialogAsetPlaystation> {
  late LinkedScrollControllerGroup tablelinkedScrollController = LinkedScrollControllerGroup();
  ScrollController tableScrollController1 = ScrollController();
  ScrollController tableScrollController2 = ScrollController();

  List listDataTable = [];
  late StateSetter _dialogKategoriBarangStateSetter;

  Future<void> loadDataTable() async {
    print("loadDataTable...");
    setState(() {
      listDataTable = [];
    });
    http.Response response = await ApiAsetPlaystation.viewAset();
    setState(() {
      listDataTable = jsonDecode(response.body);
    });
  }

  int dialogPage = 0;
  int indexRadioJenisPS = -1;
  int indexMapSelected = 0;

  TextEditingController ipAddress = TextEditingController();
  TextEditingController noMeja = TextEditingController();
  String ipAddressString = "";
  String noMejaString = "";

  List<Map<String, dynamic>> listJenisPS = [
    {"index": 0, "jenis_ps": "PS3"},
    {"index": 1, "jenis_ps": "PS4"},
    {"index": 2, "jenis_ps": "PS5"}
  ];

  void showDialogJenisPS() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Jenis PS"),
      ),
    );
  }

  void actionListener(int index) {
    setState(() {
      indexRadioJenisPS = index;
    });
  }

  int initEditState = 0;

  void dialogRadioJenisPS({required BuildContext context, int? indexJenisPS}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int _indexRadioKategori = indexRadioJenisPS;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            _dialogKategoriBarangStateSetter = setState;
            return AlertDialog(
              title: Text("Pilih Kategori Barang"),
              contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
              content: Container(
                color: Colors.white10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: listJenisPS
                      .map(
                        (e) => RadioListTile(
                          value: e["index"],
                          groupValue: _indexRadioKategori,
                          title: Text("${e["jenis_ps"]}"),
                          onChanged: (dynamic value) {
                            _dialogKategoriBarangStateSetter(() {
                              _indexRadioKategori = value;
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("CANCEL"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    actionListener(_indexRadioKategori);
                  },
                  child: Text("OKAY"),
                ),
              ],
            );
          },
        );
      },
      barrierDismissible: false,
    );
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
    return AlertDialog(
      title: dialogPage == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Aset Playstation"),
                TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                  onPressed: () {
                    setState(() {
                      dialogPage = 1;
                    });
                  },
                  icon: Icon(Icons.add),
                  label: Text("TAMBAH"),
                ),
              ],
            )
          : Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        dialogPage = 0;
                        indexRadioJenisPS = -1;
                        ipAddress = TextEditingController(text: "");
                        noMeja = TextEditingController(text: "");
                      });
                    },
                    icon: Icon(Icons.arrow_back)),
                SizedBox(width: 8),
                Text(dialogPage == 1 ? "Tambah Aset PlayStation" : "Edit Aset Playstation"),
              ],
            ),
      insetPadding: EdgeInsets.all(24),
      contentPadding: EdgeInsets.all(12),
      content: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(minHeight: 200, maxHeight: 360),
        child: dialogPage == 0 ? halamanAwal() : halamanTambahEdit(),
      ),
      actions: dialogPage == 0
          ? []
          : [
              TextButton(
                style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                onPressed: () {
                  late Map<String, dynamic> map;
                  print("dialogPage : " + dialogPage.toString());
                  if (dialogPage == 1) {
                    map = {
                      "ip": ipAddress.text,
                      "jenisps": listJenisPS[indexRadioJenisPS]["jenis_ps"],
                    };
                    ApiAsetPlaystation.tambahMeja(map: map).then((value) {
                      setState(() {
                        dialogPage = 0;
                        indexRadioJenisPS = 0;
                      });
                      loadDataTable();
                    });
                  } else if (dialogPage == 2) {
                    map = {
                      "id": listDataTable[indexMapSelected]["id_ps"],
                      "ip": ipAddress.text,
                      "jenisps": listJenisPS[indexRadioJenisPS]["jenis_ps"],
                      "nomormeja": noMeja.text
                    };
                    ApiAsetPlaystation.editMeja(map: map).then((value) {
                      setState(() {
                        dialogPage = 0;
                        indexRadioJenisPS = 0;
                      });
                      loadDataTable();
                    });
                  }
                  print(map);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(dialogPage == 1 ? "TAMBAH ASET" : "SIMPAN PERUBAHAN"),
                  ),
                ),
              ),
            ],
    );
  }

  Widget halamanAwal() {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          height: 60,
          child: Row(
            children: [
              Material(
                  elevation: 4,
                  color: Colors.blue,
                  child: Container(width: 300 * 0.125, child: Center(child: Text("No.", style: TextStyle(color: Colors.white))))),
              Expanded(
                  child: SingleChildScrollView(
                controller: tableScrollController1,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 300 * 0.225, child: Center(child: Text("No. Meja", style: TextStyle(color: Colors.white)))),
                    Container(width: 300 * 0.275, child: Center(child: Text("Jenis PS", style: TextStyle(color: Colors.white)))),
                    Container(width: 300 * 0.375, child: Center(child: Text("IP Address", style: TextStyle(color: Colors.white)))),
                    Container(width: 300 * 0.375, child: Center(child: Text("Aksi", style: TextStyle(color: Colors.white)))),
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
                            Container(width: 300 * 0.125, child: Center(child: Text("$index."))),
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
                              Container(width: 300 * 0.225, child: Center(child: Text("${e1["no_ps"]}"))),
                              Container(width: 300 * 0.275, child: Center(child: Text("${e1["jenis_ps"]}"))),
                              Container(width: 300 * 0.375, child: Center(child: Text("${e1["ip_ps"]}"))),
                              Container(
                                width: 300 * 0.375,
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
                                            indexMapSelected = index;
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
                                                          ApiAsetPlaystation.removeMeja(map: {"id_ps": e1["id_ps"]}).then((value) {
                                                            Navigator.pop(ctx);
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
    );
  }

  Widget halamanTambahEdit() {
    Map<String, dynamic> map = listDataTable[indexMapSelected];
    if (dialogPage == 2 && initEditState == 0) {
      indexRadioJenisPS = map["jenis_ps"] == "PS3"
          ? 0
          : map["jenis_ps"] == "PS4"
              ? 1
              : map["jenis_ps"] == "PS5"
                  ? 2
                  : -1;
      ipAddress = TextEditingController(text: map["ip_ps"].toString());
      noMeja = TextEditingController(text: map["no_ps"]);
      setState(() {
        initEditState = 1;
        ipAddress = TextEditingController(text: map["ip_ps"].toString());
        noMeja = TextEditingController(text: map["no_ps"]);
        ipAddressString = map["ip_ps"].toString();
        noMejaString = map["no_ps"];
      });
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.white10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dialogPage == 1
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("No. Meja"),
                          ),
                          TextFormField(
                            controller: noMeja,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.tv,
                              ),
                            ),
                            onChanged: (_) {
                              setState(() {
                                noMejaString = _;
                              });
                            },
                          ),
                        ],
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("IP. Address"),
                    ),
                    TextFormField(
                      controller: ipAddress,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.alternate_email_outlined,
                          ),
                          hintText: "Isikan alamat IP Address"),
                      onChanged: (_) {
                        setState(() {
                          ipAddressString = _;
                        });
                      },
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.sort),
                  title: Text("Jenis Playstation"),
                  trailing: Text(indexRadioJenisPS == -1 ? "Pilih Jenis PS" : listJenisPS[indexRadioJenisPS]["jenis_ps"]),
                  onTap: () {
                    setState(() {
                      ipAddress.text = ipAddressString;
                      noMeja.text = noMejaString;
                    });
                    dialogRadioJenisPS(context: context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
