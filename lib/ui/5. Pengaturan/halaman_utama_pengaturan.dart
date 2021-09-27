import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/halaman/1.halaman_aset_playstation.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/halaman/2.halaman_daftar_dagangan.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/halaman/3.halaman_daftar_harga_paket_ps.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/halaman/4.halaman_daftar_operator.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/halaman/5.halaman_setting_point.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/halaman/6.halaman_setting_voucher.dart';

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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text("Pengaturan"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanAsetPlaystation()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanDaftarOperator()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanSettingPoint()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanSettingVoucher()));
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
