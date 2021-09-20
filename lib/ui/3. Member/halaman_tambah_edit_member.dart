import 'package:flutter/material.dart';
import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:flutter_loca_game/ui/3.%20Member/api_member.dart';

class HalamanTambahEditMember extends StatefulWidget {
  const HalamanTambahEditMember({Key? key, required this.addOrEdit, required this.map}) : super(key: key);
  final Map<String, dynamic> map;
  final String addOrEdit;

  @override
  _HalamanTambahEditMemberState createState() => _HalamanTambahEditMemberState();
}

class _HalamanTambahEditMemberState extends State<HalamanTambahEditMember> {
  TextEditingController username = TextEditingController();
  TextEditingController deposit = TextEditingController();
  TextEditingController masaAktif = TextEditingController();
  String usernameString = "";
  String depositString = "";
  String masaAktifString = "";

  List<String> listJenisPS = ["PS3", "PS4", "PS5"];
  String stringListJenisPS = "PS3";
  late StateSetter _stateSetterJenisPS;

  void actionJenisPSListener(String index) {
    setState(() {
      stringListJenisPS = index;
    });
  }

  void dialogJenisPS({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (_) {
        String indexStringListJenisPS = stringListJenisPS;
        return StatefulBuilder(builder: (BuildContext __, StateSetter setter) {
          _stateSetterJenisPS = setter;
          return AlertDialog(
            title: Text("Jenis PS"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: listJenisPS
                  .map(
                    (e) => RadioListTile(
                      value: e,
                      groupValue: indexStringListJenisPS,
                      title: Text("$e"),
                      onChanged: (dynamic value) {
                        _stateSetterJenisPS(() {
                          indexStringListJenisPS = value;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(__);
                },
                child: Text("CANCEL"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(__);
                  actionJenisPSListener(indexStringListJenisPS);
                },
                child: Text("OKAY"),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.addOrEdit == "edit") {
      setState(() {
        username.text = widget.map["username"];
        usernameString = widget.map["username"];
        stringListJenisPS = widget.map["jenisps"];
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.addOrEdit == "add" ? "Tambah Member" : "Perbarui Member"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text("Username", style: TextStyle(fontSize: 16)),
                  TextFormField(
                    controller: username,
                    enabled: widget.addOrEdit == "add" ? true : false,
                    decoration: InputDecoration(
                      hintText: "Username",
                    ),
                    onChanged: (_) {
                      setState(() {
                        usernameString = _;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 16),
                  Material(
                    elevation: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: Icon(Icons.sort),
                        title: Text("Jenis PS"),
                        trailing: Text("$stringListJenisPS", overflow: TextOverflow.ellipsis),
                        onTap: () {
                          dialogJenisPS(context: context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(widget.addOrEdit == "edit" ? "Isi ulang deposit" : "Deposit", style: TextStyle(fontSize: 16)),
                  TextFormField(
                    controller: deposit,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: widget.addOrEdit == "edit" ? "Isi ulang deposit" : "Deposit",
                    ),
                    onChanged: (_) {
                      setState(() {
                        depositString = _;
                      });
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text("Masa Aktif ", style: TextStyle(fontSize: 16)),
                      Text("*jumlah hari", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  TextFormField(
                    controller: masaAktif,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Masa Aktif *jumlah hari",
                    ),
                    onChanged: (_) {
                      setState(() {
                        masaAktifString = _;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 16),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                      onPressed: usernameString == "" && depositString == "" && masaAktifString == "" ||
                              usernameString == "" ||
                              depositString == "" ||
                              masaAktifString == ""
                          ? null
                          : () async {
                              Map<String, dynamic> map = {
                                "operator": await AuthService.getCredential(),
                                "nomorps": 0,
                                "idmember": widget.addOrEdit == "add" ? "" : widget.map["idmember"],
                                "username": username.text,
                                "jenisps": stringListJenisPS,
                                "jenistarif": "deposit member",
                                "mulai": 0,
                                "selesai": 0,
                                "durasi": 0,
                                "rental": 0,
                                "shop": 0,
                                "total": deposit.text,
                                "bayar": 0,
                                "kembalian": 0,
                                "keranjang": 0,
                                "deposit": deposit.text,
                                "masaaktif": masaAktif.text,
                              };
                              print(map);
                              widget.addOrEdit == "add"
                                  ? ApiMember.addListMember(map).then((value) {
                                      Navigator.pop(context);
                                      
                                    })
                                  : ApiMember.editMember(map).then((value) {
                                      Navigator.pop(context);
                                    });

                            },
                      icon: Icon(widget.addOrEdit == "add" ? Icons.add : Icons.edit),
                      label: Text(widget.addOrEdit == "add" ? "TAMBAH MEMBER" : "PERBARUI MEMBER"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
