import 'package:flutter/material.dart';

class HalamanPembayaran extends StatefulWidget {
  const HalamanPembayaran({Key? key, required this.map, required this.onlineOrOffline}) : super(key: key);
  final Map<String, dynamic> map;
  final String onlineOrOffline;
  @override
  _HalamanPembayaranState createState() => _HalamanPembayaranState();
}

class _HalamanPembayaranState extends State<HalamanPembayaran> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade500,
        foregroundColor: Colors.black,
        title: Text("Pembayaran ${widget.map["jenisps"]} meja ${widget.map["idmonitor"]}"),
      ),
      body: SingleChildScrollView(child: widget.onlineOrOffline == "online" ? halamanOnline() : halamanOffline()),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {},
              
              icon: Icon(Icons.loop),
              label: Container(child: Text("REBOOT")),
            ),
            TextButton.icon(
              onPressed: () {
                dialogKonfirmShutDown(context);
              },
              icon: Icon(Icons.power_settings_new_outlined),
              label: Container(child: Text("SHUTDOWN")),
            ),
            TextButton.icon(
              onPressed: () {
                dialogKirimPesan(context);
              },
              icon: Icon(Icons.message_outlined),
              label: Container(child: Text("PESAN")),
            ),
          ],
        ),
      ],
    );
  }

  Widget halamanOffline() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_money_outlined,
              ),
              Text(
                "Belum Bayar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: "Rental : "),
                TextSpan(text: "Rp.000\n\n", style: TextStyle(color: Colors.green.shade900, backgroundColor: Colors.green.shade100)),
                TextSpan(text: "Shop : "),
                TextSpan(text: "Rp.000\n\n", style: TextStyle(color: Colors.green.shade900, backgroundColor: Colors.green.shade100)),
                TextSpan(text: "Total : ", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "Rp.000", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900, backgroundColor: Colors.green.shade100)),
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
          SizedBox(height: 24),
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

  Widget halamanOnline() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.475,
                child: TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.black, backgroundColor: Colors.amber.shade400),
                  onPressed: () {},
                  icon: Icon(Icons.av_timer_outlined),
                  label: Text("TAMBAH DURASI"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.475,
                child: TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.redAccent),
                  onPressed: () {},
                  icon: Icon(Icons.av_timer_outlined),
                  label: Text("KURANGI DURASI"),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Divider(),
          SizedBox(height: 24),
          Material(
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.sort),
              title: Text("Ganti Jenis Tarif"),
              trailing: Text(""),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.425,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.refresh),
                  label: Text("RESET TARIF"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.425,
                child: TextButton.icon(
                  style: TextButton.styleFrom(backgroundColor: Colors.redAccent, primary: Colors.white),
                  onPressed: () {},
                  icon: Icon(Icons.check),
                  label: Text("KONFIRMASI"),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text("Operator"),
          Divider(),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.320,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.swap_horiz),
                  label: Text("PINDAH PS"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.600,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.timer),
                  label: Text("TRANSFER WAKTU KE MEJA"),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          FractionallySizedBox(
            widthFactor: 1,
            child: TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.redAccent, fixedSize: Size.fromHeight(72)),
              icon: Icon(Icons.pan_tool),
              onPressed: () {},
              label: Text("STOP"),
            ),
          )
        ],
      ),
    );
  }
}
