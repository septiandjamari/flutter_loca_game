import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/api/2.api_daftar_dagangan.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class HalamanDaftarDagangan extends StatefulWidget {
  const HalamanDaftarDagangan({Key? key}) : super(key: key);

  @override
  _HalamanDaftarDaganganState createState() => _HalamanDaftarDaganganState();
}

class _HalamanDaftarDaganganState extends State<HalamanDaftarDagangan> {
  TextEditingController searchController = TextEditingController();

  late LinkedScrollControllerGroup tablelinkedScrollController = LinkedScrollControllerGroup();
  ScrollController tableScrollController1 = ScrollController();
  ScrollController tableScrollController2 = ScrollController();

  TextEditingController namaBarang = TextEditingController();
  TextEditingController hargaBeli = TextEditingController();
  TextEditingController hargaEcer = TextEditingController();
  TextEditingController hargaGrosir = TextEditingController();
  TextEditingController hargaAgen = TextEditingController();
  TextEditingController kategori = TextEditingController();
  TextEditingController ubahStok = TextEditingController();
  TextEditingController tambahStok = TextEditingController();

  String namaBarangString = "";
  String hargaBeliString = "";
  String hargaEcerString = "";
  String hargaGrosirString = "";
  String hargaAgenString = "";
  String kategoriString = "";
  String ubahStokString = "";
  List<String> listHargaJual = [];

  bool switchUbahStok = false;

  @override
  void initState() {
    super.initState();
    tableScrollController1 = tablelinkedScrollController.addAndGet();
    tableScrollController2 = tablelinkedScrollController.addAndGet();
    viewBarang();
  }

  int initEditState = 0;
  List<dynamic> listDataTable = [];
  int indexDataTable = -1;
  int paginationPage = 1;

  Future<void> viewBarang() async {
    setState(() {
      listDataTable = [];
    });
    var jsonResponse;
    Future.delayed(Duration(milliseconds: 100), () async {
      await ApiDaftarDagangan.viewBarang(halaman: paginationPage).then((value) {
        jsonResponse = jsonDecode(value.body);
        setState(() {
          listDataTable = jsonResponse;
        });
      });
    });
  }

  void resetAllFormValue() {
    setState(() {
      page = 0;
      initEditState = 0;
      switchUbahStok = false;
      ubahStok.text = "";
      namaBarang.text = "";
      hargaBeli.text = "";
      hargaEcer.text = "";
      hargaGrosir.text = "";
      hargaAgen.text = "";
      kategori.text = "";
      ubahStok.text = "";
      namaBarangString = "";
      hargaBeliString = "";
      hargaEcerString = "";
      hargaGrosirString = "";
      hargaAgenString = "";
      kategoriString = "";
      ubahStokString = "";
    });
  }

  @override
  void dispose() {
    tableScrollController1.dispose();
    tableScrollController2.dispose();
    super.dispose();
  }

  void dialogTambahStok(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Tambah Stok Barang"),
          content: TextFormField(
            controller: tambahStok,
            decoration: InputDecoration(hintText: "Masukkan jumlah stok"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(_);
                  },
                  child: Text("CANCEL"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(_);
                    setState(() {
                      ApiDaftarDagangan.tambahStok(map: {"idbarang": listDataTable[indexDataTable]["idbarang"], "stok": tambahStok.text}).then((value) {
                        resetAllFormValue();
                        viewBarang();
                      });
                    });
                    Future.delayed(Duration(milliseconds: 250), () {
                      setState(() {
                        tambahStok = TextEditingController(text: "");
                      });
                    });
                  },
                  child: Text("OKAY"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  int page = 0;

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
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          brightness: Brightness.dark,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              page == 0
                  ? "Daftar Dagangan"
                  : page == 1
                      ? "Tambah Dagangan"
                      : "Edit Dagangan",
            ),
          ),
          actions: page == 0
              ? [
                  IconButton(onPressed: () {}, icon: Icon(Icons.picture_as_pdf)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
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
                  ),
                ]
              : page == 1
                  ? null
                  : [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            dialogTambahStok(context);
                          },
                          icon: Icon(Icons.add),
                          label: Text("TAMBAH STOK"),
                        ),
                      ),
                    ],
        ),
        body: page == 0 ? mainPage(context) : addEditPage(),
        bottomNavigationBar: page == 0
            ? Container(
                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FloatingActionButton(
                          heroTag: 2,
                          backgroundColor: Colors.blue,
                          onPressed: () {},
                          child: Icon(Icons.chevron_left, color: Colors.white),
                        ),
                        SizedBox(width: 16),
                        FloatingActionButton(
                          heroTag: 3,
                          backgroundColor: Colors.blue,
                          onPressed: () {},
                          child: Icon(Icons.chevron_right, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  Widget mainPage(BuildContext context) {
    double gridSize1 = MediaQuery.of(context).size.width / 11;
    // double gridSize2 = MediaQuery.of(context).size.width / 2.5;
    double gridSize3 = MediaQuery.of(context).size.width / 3;
    double gridSize4 = MediaQuery.of(context).size.width / 2;
    // double gridSize5 = MediaQuery.of(context).size.width / 4;
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        children: [
          // Text(logininfo),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Container(
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Cari nama barang",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  elevation: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.475,
                    child: ListTile(
                      leading: Icon(Icons.sort),
                      title: Text("Kategori"),
                      subtitle: Text("kucing", overflow: TextOverflow.ellipsis),
                      onTap: () {},
                      dense: true,
                    ),
                  ),
                ),
                Material(
                  elevation: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.475,
                    child: ListTile(
                      leading: Icon(Icons.sort),
                      title: Text("Level Harga"),
                      subtitle: Text("kucing", overflow: TextOverflow.ellipsis),
                      onTap: () {},
                      dense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Material(
                        child: Container(
                          height: 60,
                          color: Colors.blue,
                          child: Row(
                            children: [
                              Material(
                                elevation: 4,
                                color: Colors.blue,
                                child: Row(
                                  children: [
                                    Container(
                                      width: gridSize1,
                                      child: Center(child: Text("No.", style: TextStyle(fontSize: 16, color: Colors.white))),
                                    ),
                                    Container(
                                      width: gridSize3,
                                      child: Text("Nama Barang", style: TextStyle(fontSize: 16, color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: tableScrollController1,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: gridSize3 * 0.75,
                                        child: Text("Stok", style: TextStyle(fontSize: 16, color: Colors.white)),
                                      ),
                                      Container(
                                        width: gridSize3,
                                        child: Text("Harga Beli", style: TextStyle(fontSize: 16, color: Colors.white)),
                                      ),
                                      Container(
                                        width: gridSize3 * 2.5,
                                        child: Text("Harga Jual (Ecer, Grosir, Agen)", style: TextStyle(fontSize: 16, color: Colors.white)),
                                      ),
                                      Container(
                                        width: gridSize4,
                                        child: Text("Kategori", style: TextStyle(fontSize: 16, color: Colors.white)),
                                      ),
                                      Container(
                                        width: gridSize3,
                                        child: Center(child: Text("Aksi", style: TextStyle(fontSize: 16, color: Colors.white))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: listDataTable.map((e) {
                                      var index = listDataTable.indexOf(e) + 1;
                                      return Material(
                                        elevation: 4,
                                        child: Container(
                                          color: index % 2 == 0 ? Colors.transparent : Colors.black12,
                                          height: 60,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: gridSize1,
                                                child: Center(child: Text("$index.", style: TextStyle(fontSize: 16))),
                                              ),
                                              Container(
                                                width: gridSize3,
                                                child: Text("${e["namabarang"]}", style: TextStyle(fontSize: 16)),
                                              ),
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
                                          var index = listDataTable.indexOf(e1) + 1;
                                          List hargaJual = e1["hargajual"].split(",");
                                          return Container(
                                            color: index % 2 == 0 ? Colors.transparent : Colors.black12,
                                            height: 60,
                                            child: Row(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width: gridSize3 * 0.75,
                                                    child: Text("${e1["stok"]}", style: TextStyle(fontSize: 16)),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: gridSize3,
                                                    child: Text("Rp.${e1["hargabeli"]}", style: TextStyle(fontSize: 16)),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: gridSize3 * 2.5,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                                          child: TextButton(
                                                            style: TextButton.styleFrom(
                                                                backgroundColor: Colors.blue.withOpacity(0.1),
                                                                primary: Colors.blue[600],
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                side: BorderSide(color: Colors.blue, width: 0.001)),
                                                            onPressed: () {},
                                                            child: Text("Rp.${hargaJual[0]}"),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                                          child: TextButton(
                                                            style: TextButton.styleFrom(
                                                                backgroundColor: Colors.blue.withOpacity(0.1),
                                                                primary: Colors.blue[600],
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                side: BorderSide(color: Colors.blue, width: 0.001)),
                                                            onPressed: () {},
                                                            child: Text("Rp.${hargaJual[1]}"),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                                          child: TextButton(
                                                            style: TextButton.styleFrom(
                                                                backgroundColor: Colors.blue.withOpacity(0.1),
                                                                primary: Colors.blue[600],
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                side: BorderSide(color: Colors.blue, width: 0.001)),
                                                            onPressed: () {},
                                                            child: Text("Rp.${hargaJual[2]}"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: gridSize4,
                                                    child: Text("${e1["kategori"]}", style: TextStyle(fontSize: 14)),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  width: gridSize3,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              page = 2;
                                                              indexDataTable = index - 1;
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: Colors.green,
                                                          )),
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            indexDataTable = index - 1;
                                                          });
                                                          showDialog(
                                                            barrierDismissible: false,
                                                            context: context,
                                                            builder: (_) => AlertDialog(
                                                                title: Text("Konfirmasi"),
                                                                content: Text(
                                                                  "Apakah anda yakin ingin menghapus ${e1["namabarang"]} ?",
                                                                ),
                                                                actions: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(_);
                                                                          resetAllFormValue();
                                                                        },
                                                                        child: Text("CANCEL"),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          print('map: idbarang ${e1["idbarang"]}}');
                                                                          ApiDaftarDagangan.removeDagangan(
                                                                            map: {"idbarang": e1["idbarang"]},
                                                                          ).then((value) {
                                                                            Navigator.pop(_);
                                                                            viewBarang();
                                                                            resetAllFormValue();
                                                                          });
                                                                        },
                                                                        child: Text("OKAY"),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ]),
                                                          );
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addEditPage() {
    bool isButtonActive() {
      return namaBarangString.trim() == "" &&
                  hargaBeliString.trim() == "" &&
                  hargaEcerString.trim() == "" &&
                  hargaGrosirString.trim() == "" &&
                  hargaAgenString.trim() == "" &&
                  ubahStokString.trim() == "" &&
                  kategoriString.trim() == "" ||
              namaBarangString.trim() == "" ||
              hargaBeliString.trim() == "" ||
              hargaEcerString.trim() == "" ||
              hargaGrosirString.trim() == "" ||
              hargaAgenString.trim() == "" ||
              ubahStokString.trim() == "" ||
              kategoriString.trim() == ""
          ? false
          : true;
    }

    if (page == 1) {
      setState(() {
        ubahStokString = "gak boleh kosong";
      });
    }
    if (page == 2 && initEditState == 0) {
      setState(() {
        listHargaJual = listDataTable[indexDataTable]["hargajual"].split(",");
        namaBarang = TextEditingController(text: listDataTable[indexDataTable]["namabarang"]);
        hargaBeli = TextEditingController(text: listDataTable[indexDataTable]["hargabeli"].toString());
        hargaEcer = TextEditingController(text: listHargaJual[0]);
        hargaGrosir = TextEditingController(text: listHargaJual[1]);
        hargaAgen = TextEditingController(text: listHargaJual[2]);
        kategori = TextEditingController(text: listDataTable[indexDataTable]["kategori"]);
        ubahStok = TextEditingController(text: listDataTable[indexDataTable]["stok"].toString());
        namaBarangString = listDataTable[indexDataTable]["namabarang"];
        hargaBeliString = listDataTable[indexDataTable]["hargabeli"].toString();
        hargaEcerString = listHargaJual[0];
        hargaGrosirString = listHargaJual[1];
        hargaAgenString = listHargaJual[2];
        kategoriString = listDataTable[indexDataTable]["kategori"];
        ubahStokString = listDataTable[indexDataTable]["stok"].toString();
        initEditState = 1;
      });
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama Barang", style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: namaBarang,
              decoration: InputDecoration(hintText: "Nama Barang"),
              onChanged: (_) {
                setState(() {
                  namaBarangString = _;
                });
              },
            ),
            SizedBox(height: 16),
            Text("Harga Beli", style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: hargaBeli,
              decoration: InputDecoration(hintText: "Harga Beli"),
              keyboardType: TextInputType.number,
              onChanged: (_) {
                setState(() {
                  hargaBeliString = _;
                });
              },
            ),
            SizedBox(height: 16),
            Text("Harga Jual", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ecer"),
                        TextFormField(
                          controller: hargaEcer,
                          decoration: InputDecoration(hintText: "Harga Ecer"),
                          keyboardType: TextInputType.number,
                          onChanged: (_) {
                            setState(() {
                              hargaEcerString = _;
                            });
                          },
                        ),
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Grosir"),
                        TextFormField(
                          controller: hargaGrosir,
                          decoration: InputDecoration(hintText: "Harga Grosir"),
                          keyboardType: TextInputType.number,
                          onChanged: (_) {
                            setState(() {
                              hargaGrosirString = _;
                            });
                          },
                        ),
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Agen"),
                        TextFormField(
                          controller: hargaAgen,
                          decoration: InputDecoration(hintText: "Harga Agen"),
                          keyboardType: TextInputType.number,
                          onChanged: (_) {
                            setState(() {
                              hargaAgenString = _;
                            });
                          },
                        ),
                      ],
                    )),
              ],
            ),
            page == 1
                ? SizedBox()
                : Column(
                    children: [
                      SizedBox(height: 16),
                      Row(
                        children: [
                          FlutterSwitch(
                            height: 24,
                            width: 48,
                            value: switchUbahStok,
                            onToggle: (val) {
                              setState(() {
                                switchUbahStok = val;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          Text("Ubah Stok", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          Text("* Hanya untuk ralat", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      TextFormField(
                        controller: ubahStok,
                        enabled: switchUbahStok,
                        decoration: InputDecoration(hintText: "Ubah Jumlah Stok"),
                        keyboardType: TextInputType.number,
                        onChanged: (_) {
                          setState(() {
                            ubahStokString = _;
                          });
                        },
                      ),
                    ],
                  ),
            SizedBox(height: 16),
            Text("Kategori", style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: kategori,
              decoration: InputDecoration(hintText: "Nama Kategori/tag/keyword"),
              onChanged: (_) {
                setState(() {
                  kategoriString = _;
                });
              },
            ),
            SizedBox(height: 24),
            FractionallySizedBox(
              widthFactor: 1,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: isButtonActive() == false
                    ? null
                    : () {
                        Map<String, dynamic> map;
                        if (page == 1) {
                          map = {
                            "namabarang": namaBarang.text,
                            "hargabeli": hargaBeli.text,
                            "hargajual": "${hargaEcer.text},${hargaGrosir.text},${hargaAgen.text}",
                            "kategori": kategori.text,
                          };
                          ApiDaftarDagangan.addDagangan(map: map).then((value) {
                            viewBarang();
                            resetAllFormValue();
                          });
                        } else {
                          map = {
                            "idbarang": listDataTable[indexDataTable]["idbarang"],
                            "namabarang": namaBarang.text,
                            "stok": ubahStok.text,
                            "terjual": listDataTable[indexDataTable]["terjual"],
                            "hargabeli": hargaBeli.text,
                            "hargajual": "${hargaEcer.text},${hargaGrosir.text},${hargaAgen.text}",
                            "kategori": kategori.text,
                          };
                          ApiDaftarDagangan.updateDagangan(map: map).then((value) {
                            viewBarang();
                            resetAllFormValue();
                          });
                        }
                      },
                icon: Icon(page == 1 ? Icons.add : Icons.save),
                label: Text(page == 1 ? "TAMBAH DAGANGAN" : "UPDATE DAGANGAN"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
