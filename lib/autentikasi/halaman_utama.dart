import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:flutter_loca_game/ui/1.%20toko/halaman_utama_toko.dart';
import 'package:flutter_loca_game/ui/2.%20billing/2.%20halaman_utama_billing.dart';
import 'package:flutter_loca_game/ui/3.%20Member/halaman/halaman_tambah_edit_member.dart';
import 'package:flutter_loca_game/ui/3.%20Member/halaman_utama_member.dart';
import 'package:flutter_loca_game/ui/4.laporan/halaman_utama_laporan.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/halaman_utama_pengaturan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanUtama extends StatefulWidget {
  HalamanUtama({Key? key}) : super(key: key);

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _page = 0;

  List<Widget> listPage = [
    HalamanUtamaToko(),
    HalamanUtamaBilling(),
    HalamanUtamaMember(),
    HalamanUtamaLaporan(),
  ];
  List<Widget> listTitle = [
    Text("Toko"),
    Text("Billing"),
    Text("Member"),
    Text("Laporan"),
  ];

  String cred = "";
  String role = "";
  String user = "";

  Future<void> loadSharedPref() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cred = sp.getString(AuthService.spCred)!;
    role = sp.getString(AuthService.spRole)!;
    user = sp.getString(AuthService.spUser)!;
  }

  @override
  void initState() {
    super.initState();
    loadSharedPref();
  }

  void showDialogLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Yakin logout sekarang?"),
        content: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.subtitle1,
            children: [
              TextSpan(text: "Klik tombol"),
              TextSpan(text: " unduh laporan ", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "untuk mengunduh laporan operator"),
            ],
          ),
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(onTap: () {}, trailing: Text("CANCEL", style: TextStyle(color: Colors.blue))),
              ListTile(onTap: () {}, trailing: Text("UNDUH LAPORAN", style: TextStyle(color: Colors.blue))),
              ListTile(
                  onTap: () {
                    Navigator.pop(_);
                    Future.delayed(Duration(milliseconds: 500), () {
                      AuthService.logout(context);
                    });
                  },
                  trailing: Text("LOG OUT", style: TextStyle(color: Colors.blue))),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: listTitle[_page],
        actions: _page == 2
            ? [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton.icon(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => HalamanTambahEditMember(addOrEdit: "add", map: {}),
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text("TAMBAH MEMBER"),
                  ),
                )
              ]
            : _page == 3
                ? [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton.icon(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.blue,
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            )),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HalamanTambahEditMember(
                          //               addOrEdit: "add",
                          //             )));
                        },
                        icon: Icon(Icons.refresh),
                        label: Text("REFRESH"),
                      ),
                    ),
                  ]
                : [],
      ),
      drawer: menuDrawer(),
      body: Center(
        child: listPage[_page],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _page,
        onTap: (value) {
          setState(() {
            _page = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.store_mall_directory,
              ),
              label: 'Toko'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calculate,
              ),
              label: 'Billing'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
              ),
              label: 'Member'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.description_outlined,
              ),
              label: 'Laporan'),
        ],
      ),
    );
  }

  Widget menuDrawer() {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(fit: BoxFit.contain, image: AssetImage('assets/images/locabillps.png')),
                        ),
                      ),
                    ),
                    Text(
                      "Admin 1",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        role.contains("admin")
                            ? Padding(
                                padding: EdgeInsets.all(8),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      primary: Colors.blue[600],
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      side: BorderSide(color: Colors.blue)),
                                  onPressed: () {},
                                  child: Text("admin"),
                                ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                primary: Colors.blue[600],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                side: BorderSide(color: Colors.blue)),
                            onPressed: () {},
                            child: Text("operator"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                primary: Colors.red[600],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                side: BorderSide(color: Colors.red)),
                            onPressed: () {
                              showDialogLogout(context);
                            },
                            child: Text("logout"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 48),
                    role.contains("admin")
                        ? OutlinedButton(
                            onPressed: () {},
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanUtamaPengaturan()));
                              },
                              leading: Icon(Icons.settings),
                              title: Text("Pengaturan"),
                              trailing: Icon(Icons.lock),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {},
                      child: ListTile(
                        leading: Icon(Icons.info),
                        title: Text("Tentang Aplikasi"),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(padding: const EdgeInsets.all(8.0), child: Text("Billing PS v.0.1")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
