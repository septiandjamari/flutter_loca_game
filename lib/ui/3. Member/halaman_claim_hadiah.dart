import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class HalamanClaimHadiah extends StatefulWidget {
  const HalamanClaimHadiah({Key? key}) : super(key: key);

  @override
  _HalamanClaimHadiahState createState() => _HalamanClaimHadiahState();
}

class PoinBarang {
  String id;
  String namaBarang;
  int jumlahPoin;
  bool isTaken;
  PoinBarang({
    required this.id,
    required this.namaBarang,
    required this.jumlahPoin,
    required this.isTaken,
  });
}

List<PoinBarang> listPoinBarang = [
  PoinBarang(id: randomAlphaNumeric(8), namaBarang: "Mie Boiki", jumlahPoin: 10, isTaken: false),
  PoinBarang(id: randomAlphaNumeric(8), namaBarang: "Jajan Ribut", jumlahPoin: 2, isTaken: false),
  PoinBarang(id: randomAlphaNumeric(8), namaBarang: "Coto Lamongan", jumlahPoin: 5, isTaken: false),
];

class PoinVoucher {
  String id;
  String tanggal;
  String expired;
  String jenisPS;
  int jumlahPoin;
  bool isTaken;
  PoinVoucher({
    required this.id,
    required this.tanggal,
    required this.expired,
    required this.jenisPS,
    required this.jumlahPoin,
    required this.isTaken,
  });
}

List<PoinVoucher> listPoinVoucher = [
  PoinVoucher(id: randomAlphaNumeric(8), tanggal: "21-08-2021", expired: "22-08-2021 12:00", jenisPS: "PS 3", jumlahPoin: 10, isTaken: false),
  PoinVoucher(id: randomAlphaNumeric(8), tanggal: "21-08-2021", expired: "22-08-2021 12:00", jenisPS: "PS 3", jumlahPoin: 10, isTaken: false),
  PoinVoucher(id: randomAlphaNumeric(8), tanggal: "21-08-2021", expired: "22-08-2021 12:00", jenisPS: "PS 3", jumlahPoin: 10, isTaken: false),
  PoinVoucher(id: randomAlphaNumeric(8), tanggal: "21-08-2021", expired: "22-08-2021 12:00", jenisPS: "PS 3", jumlahPoin: 10, isTaken: false),
];

List<Color> listColor = [
  Colors.yellow,
  Colors.yellow.shade300,
  Colors.blue,
  Colors.blue.shade300,
  Colors.green,
  Colors.green.shade300,
];

class _HalamanClaimHadiahState extends State<HalamanClaimHadiah> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: page,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Poin Hadiah"),
          bottom: TabBar(
            isScrollable: true,
            onTap: (value) {
              setState(() {
                page = value;
              });
            },
            tabs: [
              Tab(text: "AMBIL POIN"),
              Tab(text: "HITUNG POIN"),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.black38),
                onPressed: () {},
                icon: Icon(Icons.save),
                label: Text("SIMPAN"),
              ),
            ),
          ],
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            halaman1(),
            halaman2(),
          ],
        ),
      ),
    );
  }

  Widget halaman1() {
    return LayoutBuilder(builder: (context, constraints) {
      double halfSizeScreen = constraints.maxHeight / 2;
      return Column(
        children: [
          Container(
            height: halfSizeScreen,
            child: Column(
              children: [
                Container(
                  height: 40,
                  color: Colors.blue,
                  child: Center(
                    child: Text("POIN BARANG BELUM DIAMBIL", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  height: halfSizeScreen - 40,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: cardContainer1Halaman1(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: halfSizeScreen,
            child: Column(
              children: [
                Container(
                  height: 40,
                  color: Colors.blue,
                  child: Center(
                    child: Text("POIN VOUCHER BELUM DIAMBIL", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  height: halfSizeScreen - 40,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: cardContainer2Halaman1(),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  Widget cardContainer1Halaman1() {
    return Row(
      children: listPoinBarang
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(18),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 172,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("Id : ${e.id}", style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${e.namaBarang}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      TextButton(
                        style: TextButton.styleFrom(primary: Colors.black, backgroundColor: Colors.yellow),
                        onPressed: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Center(
                            child: Text("AMBIL (${e.jumlahPoin} poin)", style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget cardContainer2Halaman1() {
    return Row(
      children: listPoinVoucher
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(18),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 172,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("Id : ${e.id}", style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${e.jenisPS}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tanggal : ${e.tanggal}", style: TextStyle(fontSize: 10)),
                          Text("Expired : ${e.expired}", style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      TextButton(
                        style: TextButton.styleFrom(primary: Colors.black, backgroundColor: Colors.yellow),
                        onPressed: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Center(
                            child: Text("AMBIL (${e.jumlahPoin} poin)", style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget halaman2() {
    return SingleChildScrollView(
        child: Container(
      child: Column(),
    ));
  }
}
