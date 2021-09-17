import 'package:flutter/material.dart';

class DialogPembayaran extends StatefulWidget {
  const DialogPembayaran({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  _DialogPembayaranState createState() => _DialogPembayaranState();
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

class _DialogPembayaranState extends State<DialogPembayaran> {
  void dialogKonfirmShutDown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text("Konfirmasi"),
            content: Text("Ingin mematikan alamat ini?"),
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

  void dialogKirimPesan(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text("Kirim Pesan"),
            content: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Ketik pesan dibawah ini"),
                  SizedBox(height: 20),
                  TextFormField(
                    minLines: 2,
                    maxLines: 2,
                    decoration: InputDecoration(hintText: "Ketik Pesan"),
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [Text("Pembayaran meja : "), SizedBox(width: 6), mejaBadge(widget.index)],
      ),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Belum Bayar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                    TextSpan(text: "Rental : "),
                    TextSpan(text: "Rp.000\n\n", style: TextStyle(color: Colors.green.shade900, backgroundColor: Colors.green.shade100)),
                    TextSpan(text: "Shop : "),
                    TextSpan(text: "Rp.000\n\n", style: TextStyle(color: Colors.green.shade900, backgroundColor: Colors.green.shade100)),
                    TextSpan(text: "Total : ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "Rp.000", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900, backgroundColor: Colors.green.shade100)),
                  ],
                ),
              ),
              Row(
                children: [
                  Text("Rp. "),
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Bayar Uang"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Rp. "),
                  Flexible(
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(hintText: "Kembalian"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actionsPadding: EdgeInsets.all(0),
      actions: [
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.blue, primary: Colors.white),
          onPressed: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("SIMPAN")),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.swap_horiz,
                size: 14,
              ),
              label: Container(child: Text("CEK PING", style: TextStyle(fontSize: 12))),
            ),
            TextButton.icon(
              onPressed: () {
                dialogKonfirmShutDown(context);
              },
              icon: Icon(
                Icons.power_settings_new_outlined,
                size: 14,
              ),
              label: Container(child: Text("SHUTDOWN", style: TextStyle(fontSize: 12))),
            ),
            TextButton.icon(
              onPressed: () {
                dialogKirimPesan(context);
              },
              icon: Icon(
                Icons.message_outlined,
                size: 14,
              ),
              label: Container(child: Text("PESAN", style: TextStyle(fontSize: 12))),
            ),
          ],
        ),
      ],
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
