import 'package:flutter/material.dart';

class DialogTambahClient extends StatefulWidget {
  const DialogTambahClient({Key? key}) : super(key: key);

  @override
  _DialogTambahClientState createState() => _DialogTambahClientState();
}

class _DialogTambahClientState extends State<DialogTambahClient> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue,
      title: Text("Tambah Client di PS3 di Meja 1"),
      contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 12),
      content: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
        child: DefaultTabController(
          length: 4,
          initialIndex: page,
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                  color: Colors.blue,
                  child: TabBar(
                    onTap: (value) {
                      setState(() {
                        page = value;
                      });
                    },
                    tabs: [
                      Tab(text: "PERSONAL"),
                      Tab(text: "CUSTOM"),
                      Tab(text: "MEMBER"),
                      Tab(text: "VOUCHER"),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  pageContent(0),
                  pageContent(1),
                  pageContent(2),
                  pageContent(3),
                ],
              )),
        ),
      ),
    );
  }

  Widget pageContent(int index) {
    List<String> listTeksTombol = [
      "TAMBAH CLIENT PERSONAL",
      "PILIH CLIENT CUSTOM",
      "TAMBAH CLIENT MEMBER",
      "TUKAR VOUCHER",
    ];
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          index != 3
              ? Container(
                  color: Colors.white10,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_add),
                      hintText: "Username",
                    ),
                  ),
                )
              : Container(
                  color: Colors.white10,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.confirmation_number),
                      hintText: "Masukkan Kode Voucher",
                    ),
                  ),
                ),
          index != 3
              ? ListTile(
                  tileColor: Colors.white10,
                  leading: Icon(
                    Icons.sort,
                  ),
                  title: Text("Kategori"),
                  trailing: Text("Pilih paket"),
                  onTap: () {},
                  dense: true,
                )
              : SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(child: Text(listTeksTombol[index])),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
