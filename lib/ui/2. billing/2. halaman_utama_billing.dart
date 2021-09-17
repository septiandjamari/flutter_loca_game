import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/2.%20billing/dialog/dialog_pembayaran.dart';
import 'package:flutter_loca_game/ui/2.%20billing/dialog/dialog_shop.dart';
import 'package:flutter_loca_game/ui/2.%20billing/dialog/dialog_tambah_client.dart';

class HalamanUtamaBilling extends StatefulWidget {
  const HalamanUtamaBilling({Key? key}) : super(key: key);

  @override
  _HalamanUtamaBillingState createState() => _HalamanUtamaBillingState();
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

class TagNote {
  int index;
  String keterangan;
  TagNote({required this.index, required this.keterangan});
}

class _HalamanUtamaBillingState extends State<HalamanUtamaBilling> {
  TextEditingController noteController = TextEditingController(text: "");

  List<BadgeKeterangan> listWarnaStatus = [
    BadgeKeterangan(color: Colors.black12, keterangan: "Netral"),
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

  List<TagNote> listTagNote = [
    TagNote(index: 0, keterangan: "Pengrusakan"),
    TagNote(index: 1, keterangan: "Perlu Diawasi"),
    TagNote(index: 2, keterangan: "Suka Gak Bayar"),
    TagNote(index: 3, keterangan: "Suka Mencuri"),
    TagNote(index: 4, keterangan: "Nitip uang Rp."),
  ];

  void dialogAksiMeja(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Row(
          children: [
            Text("Aksi untuk meja", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 4),
            Container(
              decoration: BoxDecoration(
                  color: listWarnaStatus[listBillingInfo[index].noMeja].color,
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
                      "${listBillingInfo[index].noMeja + 1}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "${listBillingInfo[index].jenisPS}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        content: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          color: Colors.white10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.green.shade400,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.pause,
                  color: Colors.purple,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.stop,
                  color: Colors.red.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogPembayaran(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => DialogPembayaran(index: index),
    );
  }

  void dialogCatatan(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [Text("Note untuk : "), SizedBox(width: 6), mejaBadge(index)],
        ),
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(minHeight: 200, maxHeight: 360),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  children: listTagNote
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.all(4),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.all(4),
                                  primary: Colors.blue[600],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  side: BorderSide(color: Colors.blue)),
                              onPressed: () {
                                setState(() {
                                  noteController.text = e.keterangan;
                                });
                              },
                              child: Text(e.keterangan, style: TextStyle(fontSize: 12))),
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // initialValue: noteController.text,
                    controller: noteController,
                    minLines: 4,
                    maxLines: 4,
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.blue, primary: Colors.white),
            onPressed: () {},
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text("SIMPAN")),
            ),
          ),
        ],
      ),
    );
  }

  void dialogBelanja(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => DialogShop(indexMeja: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height, minWidth: MediaQuery.of(context).size.width),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Wrap(
                      alignment: WrapAlignment.start,
                      children: listWarnaStatus.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: e.color,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 0.5,
                                    )),
                              ),
                              SizedBox(width: 10),
                              Text(e.keterangan),
                            ],
                          ),
                        );
                      }).toList()),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.625,
                    crossAxisCount: MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ? 2 : 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: listBillingInfo.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          dialogAksiMeja(context, index);
                                        },
                                        child: mejaBadge(index),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          dialogPembayaran(context, index);
                                        },
                                        child: Icon(Icons.sports_score_outlined),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${listBillingInfo[index].noMeja}", style: TextStyle(fontSize: 84, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nama : ${listBillingInfo[index].nama}", style: TextStyle(fontSize: 12)),
                                    Text("Tarif : ${listBillingInfo[index].tarif}", style: TextStyle(fontSize: 12)),
                                    Text("Waktu Mulai : ${listBillingInfo[index].waktuMulai}", style: TextStyle(fontSize: 12)),
                                    Text("Durasi : ${listBillingInfo[index].durasi}", style: TextStyle(fontSize: 12)),
                                    Text("Saldo : ${listBillingInfo[index].saldo}", style: TextStyle(fontSize: 12)),
                                    Text("Rental : ${listBillingInfo[index].rental}", style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            Material(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                              ),
                              child: Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        dialogCatatan(context, index);
                                      },
                                      icon: Icon(Icons.description, color: Colors.brown),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        dialogBelanja(context, index);
                                      },
                                      icon: Icon(Icons.local_mall, color: Colors.blue.shade900),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => DialogTambahClient(),
          );
        },
        child: Icon(Icons.add),
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
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
