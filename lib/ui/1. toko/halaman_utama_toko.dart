import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/1.%20toko/api_belanja_op.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class HalamanUtamaToko extends StatefulWidget {
  const HalamanUtamaToko({Key? key}) : super(key: key);

  @override
  _HalamanUtamaTokoState createState() => _HalamanUtamaTokoState();
}

class _HalamanUtamaTokoState extends State<HalamanUtamaToko> {
  TextEditingController searchController = TextEditingController();

  late LinkedScrollControllerGroup tablelinkedScrollController = LinkedScrollControllerGroup();
  ScrollController tableScrollController1 = ScrollController();
  ScrollController tableScrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    tableScrollController1 = tablelinkedScrollController.addAndGet();
    tableScrollController2 = tablelinkedScrollController.addAndGet();
    viewBarang();
  }

  List<dynamic> listDataTable = [];

  Future<void> viewBarang() async {
    var jsonResponse;
    await ApiBelanjaOP.viewBarang().then((value) {
      jsonResponse = jsonDecode(value.body);
      setState(() {
        listDataTable = jsonResponse;
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
  Widget build(BuildContext context) {
    double gridSize1 = MediaQuery.of(context).size.width / 11;
    // double gridSize2 = MediaQuery.of(context).size.width / 2.5;
    double gridSize3 = MediaQuery.of(context).size.width / 3;
    double gridSize4 = MediaQuery.of(context).size.width / 2;
    double gridSize5 = MediaQuery.of(context).size.width / 4;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width, minHeight: MediaQuery.of(context).size.height),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "Ketik nama barang / kategori",
                          hintStyle: TextStyle(fontSize: 12),
                          suffixIcon: Icon(Icons.search, color: Colors.red),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(40)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(40)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.red.shade400,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Icon(Icons.refresh),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.green.shade400,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ],
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
                                          width: gridSize3,
                                          child: Text("Harga", style: TextStyle(fontSize: 16, color: Colors.white)),
                                        ),
                                        Container(
                                          width: gridSize3,
                                          child: Text("Stok", style: TextStyle(fontSize: 16, color: Colors.white)),
                                        ),
                                        Container(
                                          width: gridSize4,
                                          child: Text("Kategori", style: TextStyle(fontSize: 16, color: Colors.white)),
                                        ),
                                        Container(
                                          width: gridSize5,
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
                                            return Container(
                                              color: index % 2 == 0 ? Colors.transparent : Colors.black12,
                                              height: 60,
                                              child: Row(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      width: gridSize3,
                                                      child: Text("Rp.${e1["hargabeli"]}", style: TextStyle(fontSize: 16)),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      width: gridSize3,
                                                      child: Text("${e1["stok"]}", style: TextStyle(fontSize: 16)),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      width: gridSize4,
                                                      child: Text("${e1["kategori"]}", style: TextStyle(fontSize: 16)),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    width: gridSize5,
                                                    child: TextButton(
                                                      style: TextButton.styleFrom(
                                                        onSurface: Colors.grey.shade900,
                                                        primary: Colors.black,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                        backgroundColor: Colors.yellow,
                                                      ),
                                                      onPressed: e1["stok"] != 0 ? () {} : null,
                                                      child: Text("TAMBAH"),
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
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            FloatingActionButton.extended(
              heroTag: 1,
              backgroundColor: Colors.blue,
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Text(
                "3 Item dikeranjang",
                style: TextStyle(color: Colors.white),
              ),
            ),
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
      ),
    );
  }
}
