import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/3.%20Member/halaman_claim_hadiah.dart';
import 'package:flutter_loca_game/ui/3.%20Member/halaman_tambah_edit_member.dart';

class HalamanUtamaMember extends StatefulWidget {
  const HalamanUtamaMember({Key? key}) : super(key: key);
  

  @override
  _HalamanUtamaMemberState createState() => _HalamanUtamaMemberState();
}

class MemberInfo {
  int id;
  String username;
  String jenisPS;
  String sisaSaldo;
  String deposit;
  String masaAktif;
  String poinHadiah;
  MemberInfo({
    required this.id,
    required this.username,
    required this.jenisPS,
    required this.sisaSaldo,
    required this.deposit,
    required this.masaAktif,
    required this.poinHadiah,
  });
}

List<MemberInfo> listMemberInfo = [
  MemberInfo(id: 1, username: "Username 1", jenisPS: "PS 3", sisaSaldo: "Rp.10,000", deposit: "Rp.5,000", masaAktif: "21-08-2021", poinHadiah: "1000"),
  MemberInfo(id: 2, username: "Username 2", jenisPS: "PS 3", sisaSaldo: "Rp.20,000", deposit: "Rp.10,000", masaAktif: "21-08-2021", poinHadiah: "2000"),
  MemberInfo(id: 3, username: "Username 3", jenisPS: "PS 3", sisaSaldo: "Rp.30,000", deposit: "Rp.15,000", masaAktif: "21-08-2021", poinHadiah: "3000"),
];

class _HalamanUtamaMemberState extends State<HalamanUtamaMember> {
  void dialogKonfirmHapus(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text("Konfirmasi"),
            content: Text("Yakin Menghapus member ID $index?"),
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
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.625,
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: listMemberInfo.length,
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
                        idBadge(index),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("User : ${listMemberInfo[index].username}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Jenis PS : ${listMemberInfo[index].jenisPS}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Sisa saldo : ${listMemberInfo[index].sisaSaldo}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Deposit : ${listMemberInfo[index].deposit}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Masa aktif : ${listMemberInfo[index].masaAktif}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Poin Hadiah : ${listMemberInfo[index].poinHadiah}"),
                        ),
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
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HalamanTambahEditMember(addOrEdit: "edit",),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.green.shade600),
                          ),
                          IconButton(
                            onPressed: () {
                              dialogKonfirmHapus(context, listMemberInfo[index].id);
                            },
                            icon: Icon(Icons.delete, color: Colors.red.shade600),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HalamanClaimHadiah(),
                                ),
                              );
                            },
                            icon: Icon(Icons.redeem_rounded, color: Colors.blue.shade900),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget idBadge(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12,
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
              "ID : ${listMemberInfo[index].id}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
