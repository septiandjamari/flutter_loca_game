import 'package:flutter/material.dart';
// import 'package:flutter_loca_game/ui/listObjectGlobal/list_object_global.dart' as objekGlobal;

class HalamanShop extends StatefulWidget {
  const HalamanShop({Key? key, required this.map}) : super(key: key);
  final Map<String, dynamic> map;
  @override
  _HalamanShopState createState() => _HalamanShopState();
}

class _HalamanShopState extends State<HalamanShop> {
  // late StateSetter _dialogKategoriBarangStateSetter;
  int indexRadioKategori = 0;

  void actionListener(int index) {
    setState(() {
      indexRadioKategori = index;
    });
  }

  void dialogTambahBelanja(BuildContext context, String namaBarang, int stokBarang) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text("Beli $namaBarang"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Stok Barang : $stokBarang"),
                Text("Jumlah Barang"),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "0"),
                )
              ],
            ),
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

  // void dialogKategoriBarang(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       int _indexRadioKategori = indexRadioKategori;
  //       int initialValue = indexRadioKategori;
  //       return StatefulBuilder(
  //         key: keydialogkategori,
  //         builder: (BuildContext context, StateSetter setState) {
  //           _dialogKategoriBarangStateSetter = setState;
  //           return AlertDialog(
  //             title: Text("Pilih Kategori Barang"),
  //             content: Container(
  //               constraints: BoxConstraints(maxHeight: 200),
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: objekGlobal.ListObjectGlobal.listRadioKategori
  //                       .map(
  //                         (e) => RadioListTile(
  //                           value: e.index,
  //                           groupValue: _indexRadioKategori,
  //                           title: Text("${e.keterangan}."),
  //                           onChanged: (dynamic value) {
  //                             _dialogKategoriBarangStateSetter(() {
  //                               _indexRadioKategori = value;
  //                             });
  //                           },
  //                         ),
  //                       )
  //                       .toList(),
  //                 ),
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () async {
  //                   Navigator.pop(context);
  //                   actionListener(_indexRadioKategori);
  //                 },
  //                 child: Text("OKAY"),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   actionListener(initialValue);
  //                 },
  //                 child: Text("CANCEL"),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //     barrierDismissible: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text("Shop ${widget.map["jenisps"]} meja ${widget.map["idmonitor"]}"), SizedBox(width: 6)],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints(minHeight: 200, maxHeight: 360),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Cari nama barang",
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.sort,
              ),
              title: Text("Kategori"),
              // trailing: Text(objekGlobal.ListObjectGlobal.listRadioKategori[indexRadioKategori].keterangan),
              onTap: () {
                // dialogKategoriBarang(context);
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: MediaQuery.of(context).size.width / 3, child: Text("Nama")),
                  Container(width: MediaQuery.of(context).size.width / 3, child: Text("Harga")),
                  Container(width: MediaQuery.of(context).size.width / 4, child: Center(child: Text("Aksi"))),
                ],
              ),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: objekGlobal.ListObjectGlobal.listDaftarBarang
            //             .map(
            //               (e) => Container(
            //                 color: e.index % 2 == 0 ? Colors.transparent : Colors.black12,
            //                 child: Row(
            //                   children: [
            //                     Container(width: MediaQuery.of(context).size.width / 4, child: Text(e.nama)),
            //                     Container(width: MediaQuery.of(context).size.width / 4, child: Text(e.harga)),
            //                     Container(
            //                       width: MediaQuery.of(context).size.width / 4,
            //                       padding: EdgeInsets.symmetric(horizontal: 12),
            //                       child: TextButton(
            //                         style: TextButton.styleFrom(
            //                           primary: Colors.white,
            //                           backgroundColor: Colors.blue,
            //                         ),
            //                         onPressed: () {
            //                           dialogTambahBelanja(context, e.nama, e.stok);
            //                         },
            //                         child: Text("ADD"),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             )
            //             .toList()),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
