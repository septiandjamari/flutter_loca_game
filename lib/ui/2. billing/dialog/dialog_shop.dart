import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/listObjectGlobal/list_object_global.dart' as objekGlobal;

class DialogShop extends StatefulWidget {
  const DialogShop({Key? key, required this.indexMeja}) : super(key: key);
  final indexMeja;
  @override
  _DialogShopState createState() => _DialogShopState();
}

class BadgeKeterangan {
  Color color;
  String keterangan;
  BadgeKeterangan({required this.color, required this.keterangan});
}

class BillingInfo {
  int noMeja;
  String jenisPS;
  String nama;
  String tarif;
  String waktuMulai;
  String durasi;
  String saldo;
  String rental;
  List<Map<String, bool>>? badgeMore = [
    {"shopBadge": false},
    {"noteBadge": false},
    {"isRunning": false},
    {"isStopped": false},
    {"isNetral": false},
  ];
  BillingInfo({
    required this.noMeja,
    required this.jenisPS,
    required this.nama,
    required this.tarif,
    required this.waktuMulai,
    required this.durasi,
    required this.saldo,
    required this.rental,
    this.badgeMore,
  });
}

List<BadgeKeterangan> listWarnaStatus = [
  BadgeKeterangan(color: Colors.transparent, keterangan: "Netral"),
  BadgeKeterangan(color: Colors.green.shade400, keterangan: "Running"),
  BadgeKeterangan(color: Colors.red.shade600, keterangan: "Stop"),
  BadgeKeterangan(color: Colors.purple, keterangan: "Pause"),
  BadgeKeterangan(color: Colors.brown, keterangan: "Ada Notes"),
  BadgeKeterangan(color: Colors.blue.shade900, keterangan: "Ada Belanjaan"),
];

List<BillingInfo> listBillingInfo = [
  BillingInfo(
    noMeja: 0,
    jenisPS: "PS3",
    nama: "nama1",
    tarif: "",
    waktuMulai: "0",
    durasi: "00:00:00",
    saldo: "Rp.000",
    rental: "Rp.000",
  ),
  BillingInfo(
    noMeja: 1,
    jenisPS: "PS3",
    nama: "nama2",
    tarif: "",
    waktuMulai: "0",
    durasi: "00:00:00",
    saldo: "Rp.000",
    rental: "Rp.000",
  ),
];

class _DialogShopState extends State<DialogShop> {
  late StateSetter _dialogKategoriBarangStateSetter;
  late Key keydialogkategori = Key(" ");
  int indexRadioKategori = 0;

  void actionListener(int index) {
    print("tombol telah di tekan");
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
            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            content: Container(
              color: Colors.white10,
              padding: EdgeInsets.all(12),
              child: Column(
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

  void dialogKategoriBarang(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int _indexRadioKategori = indexRadioKategori;
        int initialValue = indexRadioKategori;
        return StatefulBuilder(
          key: keydialogkategori,
          builder: (BuildContext context, StateSetter setState) {
            _dialogKategoriBarangStateSetter = setState;
            return AlertDialog(
              title: Text("Pilih Kategori Barang"),
              contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
              content: Container(
                color: Colors.white10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: objekGlobal.ListObjectGlobal.listRadioKategori
                      .map(
                        (e) => RadioListTile(
                          value: e.index,
                          groupValue: _indexRadioKategori,
                          title: Text("${e.keterangan}."),
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
                  onPressed: () async {
                    Navigator.pop(context);
                    actionListener(_indexRadioKategori);
                  },
                  child: Text("OKAY"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    actionListener(initialValue);
                  },
                  child: Text("CANCEL"),
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
  Widget build(BuildContext context) {
    return AlertDialog(
      key: keydialogkategori,
      insetPadding: EdgeInsets.all(24),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Shop : "), SizedBox(width: 6), mejaBadge(widget.indexMeja)],
          ),
          Row(children: [Icon(Icons.attach_money_outlined), SizedBox(width: 6), Text("Rp.000")])
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 12),
      content: Container(
        color: Colors.white10,
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(minHeight: 200, maxHeight: 360),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white10,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Cari nama barang",
                ),
              ),
            ),
            ListTile(
              tileColor: Colors.white10,
              leading: Icon(
                Icons.sort,
              ),
              title: Text("Kategori"),
              trailing: Text(objekGlobal.ListObjectGlobal.listRadioKategori[indexRadioKategori].keterangan),
              onTap: () {
                dialogKategoriBarang(context);
              },
              dense: true,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.blue,
              child: Row(
                children: [
                  Container(width: MediaQuery.of(context).size.width / 3, child: Text("Nama")),
                  Container(width: MediaQuery.of(context).size.width / 4, child: Text("Harga")),
                  Container(width: MediaQuery.of(context).size.width / 5, child: Center(child: Text("Aksi"))),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: objekGlobal.ListObjectGlobal.listDaftarBarang
                        .map(
                          (e) => Container(
                            color: e.index % 2 == 0 ? Colors.transparent : Colors.black12,
                            child: Row(
                              children: [
                                Container(width: MediaQuery.of(context).size.width / 3, child: Text(e.nama)),
                                Container(width: MediaQuery.of(context).size.width / 4, child: Text(e.harga)),
                                Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: () {
                                      dialogTambahBelanja(context, e.nama, e.stok);
                                    },
                                    child: Text("ADD"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mejaBadge(int nomorMeja) {
    return Container(
      decoration: BoxDecoration(
          color: listWarnaStatus[nomorMeja].color,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: Colors.blue,
            width: 0.5,
          )),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${listBillingInfo[nomorMeja].noMeja + 1}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(width: 6),
            Text(
              "${listBillingInfo[nomorMeja].jenisPS}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
