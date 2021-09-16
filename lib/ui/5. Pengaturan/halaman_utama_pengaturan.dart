import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/dialog&halaman/1.dialog_aset_playstation.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/dialog&halaman/2.halaman_daftar_dagangan.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/dialog&halaman/3.halaman_daftar_harga_paket_ps.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/dialog&halaman/4.dialog_daftar_operator.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/dialog&halaman/5.dialog_setting_point.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/dialog&halaman/6.dialog_setting_voucher.dart';

class HalamanUtamaPengaturan extends StatefulWidget {
  const HalamanUtamaPengaturan({Key? key}) : super(key: key);

  @override
  _HalamanUtamaPengaturanState createState() => _HalamanUtamaPengaturanState();
}

class _HalamanUtamaPengaturanState extends State<HalamanUtamaPengaturan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Pengaturan"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  showDialog(context: context, builder: (context) => DialogAsetPlaystation());
                },
                leading: Icon(
                  Icons.sports_esports,
                ),
                title: Text("Aset Playstation"),
                subtitle: Text("Pengaturan aset PS dan IP Playstation"),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanDaftarDagangan()));
                },
                leading: Icon(
                  Icons.shopping_bag,
                ),
                title: Text("Daftar Dagangan"),
                subtitle: Text("Pengaturan barang dagangan"),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanDaftarHargaPaketPS()));
                },
                leading: Icon(
                  Icons.account_balance_wallet,
                ),
                title: Text("Daftar Harga Paket PS"),
                subtitle: Text("Atur harga sewa PS"),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () {
                  showDialog(context: context, builder: (context) => DialogDaftarOperator());
                },
                leading: Icon(
                  Icons.people,
                ),
                title: Text("Daftar Operator"),
                subtitle: Text("Pengaturan operator"),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () {
                  showDialog(context: context, builder: (context) => DialogSettingPoint());
                },
                leading: Icon(
                  Icons.card_giftcard_outlined,
                ),
                title: Text("Setting Point Member dan Hadiah"),
                subtitle: Text("Pengaturan hadiah"),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () {
                  showDialog(context: context, builder: (context) => DialogSettingVoucher());
                },
                leading: Icon(
                  Icons.confirmation_number,
                ),
                title: Text("Setting Voucher"),
                subtitle: Text("Pengaturan voucher"),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
