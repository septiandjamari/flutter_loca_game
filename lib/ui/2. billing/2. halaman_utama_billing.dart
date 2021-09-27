import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:flutter_loca_game/ui/2.%20billing/halaman/halaman_pembayaran.dart';
import 'package:flutter_loca_game/ui/2.%20billing/halaman/halaman_shop.dart';
import 'package:flutter_loca_game/ui/2.%20billing/halaman/halaman_tambah_client.dart';
import 'package:intl/intl.dart';
import 'package:sse_client/sse_client.dart';

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

class TagNote {
  int index;
  String keterangan;
  TagNote({required this.index, required this.keterangan});
}

class _HalamanUtamaBillingState extends State<HalamanUtamaBilling> {
  TextEditingController noteController = TextEditingController(text: "");

  List<BadgeKeterangan> listWarnaStatus = [
    BadgeKeterangan(color: Colors.black.withOpacity(0.1), keterangan: "Netral"),
    BadgeKeterangan(color: Colors.lightGreenAccent.shade700, keterangan: "Running"),
    BadgeKeterangan(color: Colors.red.shade600, keterangan: "Stop"),
    BadgeKeterangan(color: Colors.purple, keterangan: "Pause"),
    BadgeKeterangan(color: Colors.deepOrange.shade900, keterangan: "Ada Notes"),
    BadgeKeterangan(color: Colors.blue.shade900, keterangan: "Ada Belanjaan"),
  ];

  List<TagNote> listTagNote = [
    TagNote(index: 0, keterangan: "Pengrusakan"),
    TagNote(index: 1, keterangan: "Perlu Diawasi"),
    TagNote(index: 2, keterangan: "Suka Gak Bayar"),
    TagNote(index: 3, keterangan: "Suka Mencuri"),
    TagNote(index: 4, keterangan: "Nitip uang Rp."),
  ];

  @override
  void initState() {
    super.initState();
  }

  var sseClient = SseClient.connect(Uri.parse('${AuthService.url}/monitor'));

  void dialogAksiMeja(
    BuildContext context,
    Map<String, dynamic> map,
    String keterangan,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Text("Aksi ${map["jenisps"]} meja ${map["idmonitor"]}", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 4),
          ],
        ),
        actions: [
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: keterangan == "hijau" || keterangan == "merah" ? null : () {},
                icon: Icon(
                  Icons.play_arrow,
                  color: keterangan == "hijau" || keterangan == "merah" ? Colors.grey : Colors.lightGreenAccent.shade700,
                ),
                label: Text("Resume", style: TextStyle(color: keterangan == "hijau" || keterangan == "merah" ? Colors.grey : Colors.greenAccent.shade700)),
              ),
              OutlinedButton.icon(
                onPressed: keterangan == "ungu" || keterangan == "merah" ? null : () {},
                icon: Icon(
                  Icons.pause,
                  color: keterangan == "ungu" || keterangan == "merah" ? Colors.grey : Colors.purple.shade900,
                ),
                label: Text("Pause", style: TextStyle(color: keterangan == "ungu" || keterangan == "merah" ? Colors.grey : Colors.purple.shade900)),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  late String onlineOrOffline;
                  if (keterangan == "hijau" || keterangan == "ungu") {
                    onlineOrOffline = "online";
                  } else {
                    onlineOrOffline = "offline";
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HalamanPembayaran(map: map, onlineOrOffline: onlineOrOffline),
                  ));
                },
                icon: Icon(Icons.more_vert),
                label: Text("More", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void dialogCatatan(BuildContext context, Map<String, dynamic> map) {
    setState(() {
      noteController.text = map["note"];
    });
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text("Note ${map["jenisps"]} meja ${map["idmonitor"]}"),
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
                TextFormField(
                  controller: noteController,
                  minLines: 4,
                  maxLines: 4,
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
              child: Container(
                color: Colors.black12,
                child: StreamBuilder(
                  stream: sseClient.stream,
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      List data = jsonDecode(snapshot.data);
                      String _printDuration(Duration duration) {
                        String twoDigits(int n) => n.toString().padLeft(2, "0");
                        String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
                        String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
                        return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
                      }

                      return GridView.builder(
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.500,
                          crossAxisCount: MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ? 2 : 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          List<dynamic> cardInfo() {
                            late Color warnaKartu;
                            late Color warnaTulisan;
                            late String keterangan;
                            if (data[index]["online"] == 1) {
                              if (List.from(data[index]["tabelwaktu"]).length % 2 == 1) {
                                warnaKartu = Colors.purple.shade900;
                                warnaTulisan = Colors.white;
                                keterangan = "ungu";
                              } else if (List.from(data[index]["tabelwaktu"]).length % 2 == 0) {
                                warnaKartu = Colors.lightGreenAccent.shade700;
                                warnaTulisan = Colors.black;
                                keterangan = "hijau";
                              }
                            }
                            if (data[index]["stop"] == 1) {
                              warnaKartu = Colors.redAccent.shade700;
                              warnaTulisan = Colors.white;
                              keterangan = "merah";
                            }
                            if (data[index]["online"] == 0 && data[index]["stop"] == 0) {
                              if (data[index]["nama"] != "") {
                                warnaKartu = Colors.redAccent.shade700;
                                warnaTulisan = Colors.white;
                                keterangan = "merah";
                              } else {
                                warnaKartu = Colors.grey.withOpacity(0.1);
                                warnaTulisan = Colors.black;
                                keterangan = "netral";
                              }
                            }
                            return [warnaKartu, warnaTulisan, keterangan];
                          }

                          Map<String, dynamic> mapPsMonitor = {"idmonitor": data[index]["idmonitor"], "jenisps": data[index]["jenisps"]};

                          return Card(
                            color: cardInfo()[0],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: InkWell(
                              onTap: cardInfo()[2] == "netral"
                                  ? () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => HalamanTambahClient(
                                          map: mapPsMonitor,
                                        ),
                                      ));
                                    }
                                  : cardInfo()[2] == "hijau"
                                      ? () {
                                          dialogAksiMeja(context, mapPsMonitor, cardInfo()[2]);
                                        }
                                      : cardInfo()[2] == "ungu"
                                          ? () {
                                              dialogAksiMeja(context, mapPsMonitor, cardInfo()[2]);
                                            }
                                          //merah
                                          : () {
                                              dialogAksiMeja(context, mapPsMonitor, cardInfo()[2]);
                                            },
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${data[index]["idmonitor"]}", style: TextStyle(fontSize: 96, fontWeight: FontWeight.bold, color: cardInfo()[1])),
                                        SizedBox(width: 8),
                                        Text("${data[index]["jenisps"]}", style: TextStyle(fontWeight: FontWeight.bold, color: cardInfo()[1])),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          color: Colors.white60,
                                          child: Table(
                                            border: TableBorder.all(),
                                            // columnWidths: {0: FractionColumnWidth(.5), 1: FractionColumnWidth(.5)},
                                            children: [
                                              TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text("Nama"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text("${data[index]["nama"]}"),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text("Tarif"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text("${data[index]["namapaket"]}"),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text("Waktu Mulai"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text(data[index]["nama"] != ""
                                                      ? "${DateFormat.yMd("id_ID").add_Hm().format(DateTime.fromMillisecondsSinceEpoch(data[index]["waktumulai"] * 1000))}"
                                                      : ""),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text("Durasi"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text("${_printDuration(Duration(seconds: data[index]["durasidetik"]))}"),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text("Saldo"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text(
                                                      "${data[index]["sisasaldo"] == "inf" ? "00:00:00" : _printDuration(Duration(seconds: double.parse(data[index]["sisasaldo"]).toInt()))}"),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text("Rental"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text("Rp.${data[index]["rental"].toString().replaceFirst(".0", "")}"),
                                                ),
                                              ]),
                                            ],
                                          ),
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
                                                TextButton.icon(
                                                  style: TextButton.styleFrom(
                                                      primary: cardInfo()[2] == "netral" || cardInfo()[2] == "merah"
                                                          ? Colors.grey.shade300
                                                          : data[index]["note"]["note"] == "" || data[index]["note"]["note"] == null
                                                              ? Colors.black45
                                                              : Colors.deepOrange.shade900),
                                                  icon: Icon(Icons.description),
                                                  label: Text("Note"),
                                                  onPressed: cardInfo()[2] == "netral" || cardInfo()[2] == "merah"
                                                      ? () {}
                                                      : () {
                                                          Map<String, dynamic> mapUpdate = mapPsMonitor;
                                                          mapUpdate.addAll({"note": data[index]["note"]["note"]});
                                                          dialogCatatan(context, mapUpdate);
                                                        },
                                                ),
                                                TextButton.icon(
                                                  style: TextButton.styleFrom(
                                                      primary: cardInfo()[2] == "netral" || cardInfo()[2] == "merah"
                                                          ? Colors.grey.shade300
                                                          : data[index]["shop"] == "0" || data[index]["shop"] == null
                                                              ? Colors.black45
                                                              : Colors.blue.shade900),
                                                  icon: Icon(Icons.local_mall),
                                                  label: Text("Shop"),
                                                  onPressed: cardInfo()[2] == "netral" || cardInfo()[2] == "merah"
                                                      ? () {}
                                                      : () {
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => HalamanShop(
                                                              map: {"idmonitor": data[index]['idmonitor'], "jenisps": data[index]['jenisps']},
                                                            ),
                                                          ));
                                                        },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
