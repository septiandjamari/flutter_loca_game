import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/api/6.api_setting_voucher.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class HalamanSettingVoucher extends StatefulWidget {
  const HalamanSettingVoucher({Key? key}) : super(key: key);

  @override
  _HalamanSettingVoucherState createState() => _HalamanSettingVoucherState();
}

class _HalamanSettingVoucherState extends State<HalamanSettingVoucher> {
  late LinkedScrollControllerGroup tablelinkedScrollController = LinkedScrollControllerGroup();
  ScrollController tableScrollController1 = ScrollController();
  ScrollController tableScrollController2 = ScrollController();

  TextEditingController namaVoucher = TextEditingController();
  TextEditingController point = TextEditingController();
  TextEditingController kodeVoucher = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController expired = TextEditingController();
  TextEditingController menit = TextEditingController();
  String namaVoucherString = "";
  String pointString = "";
  String kodeVoucherString = "";
  String keteranganString = "";
  String expiredString = "";
  String menitString = "";

  List<String> listJenisPS = ["PS3", "PS4", "PS5"];
  String stringListJenisPS = "";
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

  List listDataTable = [];
  int indexListDataTable = -1;

  Future<void> loadDataTable() async {
    setState(() {
      listDataTable = [];
    });
    ApiSettingVoucher.getVoucher().then((value) {
      setState(() {
        listDataTable = jsonDecode(value.body);
      });
    });
  }

  void resetAllFormValue() {
    setState(() {
      page = 0;
      indexListDataTable = -1;
      initEditState = 0;
      namaVoucher.text = "";
      point.text = "";
      kodeVoucher.text = "";
      keterangan.text = "";
      stringListJenisPS = "";
      expired.text = "";
      menit.text = "";
      namaVoucherString = "";
      pointString = "";
      kodeVoucherString = "";
      keteranganString = "";
      expiredString = "";
      menitString = "";
    });
  }

  int initEditState = 0;
  int page = 0;

  @override
  void initState() {
    super.initState();
    tableScrollController1 = tablelinkedScrollController.addAndGet();
    tableScrollController2 = tablelinkedScrollController.addAndGet();
    loadDataTable();
  }

  @override
  void dispose() {
    tableScrollController1.dispose();
    tableScrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (page == 0) {
          return true;
        } else {
          resetAllFormValue();
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(page == 0
              ? "Setting Voucher"
              : page == 1
                  ? "Tambah Voucher"
                  : "Update Voucher"),
          actions: page == 0
              ? [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue, side: BorderSide(color: Colors.white, width: 1)),
                      onPressed: () {
                        setState(() {
                          page = 1;
                        });
                      },
                      icon: Icon(Icons.add),
                      label: Text("TAMBAH"),
                    ),
                  )
                ]
              : null,
        ),
        body: Container(
          child: page == 0 ? halamanAwal(context) : halamanTambahEdit(),
        ),
      ),
    );
  }

  Widget halamanAwal(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          color: Colors.blue,
          height: 60,
          child: Row(
            children: [
              Material(
                  elevation: 2,
                  color: Colors.blue,
                  child: Container(width: lebar * 0.125, child: Center(child: Text("No.", style: TextStyle(color: Colors.white))))),
              Expanded(
                  child: SingleChildScrollView(
                controller: tableScrollController1,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: lebar * 0.375, child: Text("Nama Voucher", style: TextStyle(color: Colors.white))),
                    Container(width: lebar * 0.275, child: Text("Jenis PS", style: TextStyle(color: Colors.white))),
                    Container(width: lebar * 0.375, child: Text("Kode Voucher", style: TextStyle(color: Colors.white))),
                    Container(width: lebar * 0.375, child: Text("Expired", style: TextStyle(color: Colors.white))),
                    Container(width: lebar * 0.375, child: Center(child: Text("Aksi", style: TextStyle(color: Colors.white)))),
                  ],
                ),
              ))
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: listDataTable.map((e) {
                    int index = listDataTable.indexOf(e) + 1;
                    return Material(
                      elevation: 2,
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.black12,
                        height: 60,
                        child: Row(
                          children: [
                            Container(width: lebar * 0.125, child: Center(child: Text("$index."))),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: tableScrollController2,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: listDataTable.map((e1) {
                        int index = listDataTable.indexOf(e1);
                        return Container(
                          color: index % 2 != 0 ? Colors.transparent : Colors.black12,
                          height: 60,
                          child: Row(
                            children: [
                              Container(width: lebar * 0.375, child: Text(e1["namavoucher"])),
                              Container(width: lebar * 0.275, child: Text(e1["jenisps"])),
                              Container(width: lebar * 0.375, child: Text(e1["koderefeal"])),
                              Container(width: lebar * 0.375, child: Text(e1["expired_date"])),
                              Container(
                                width: lebar * 0.375,
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.green),
                                        onPressed: () {
                                          setState(() {
                                            page = 2;
                                            initEditState = 0;
                                            indexListDataTable = index;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text("Hapus data Aset PS"),
                                              content: Text("Apakah anda yakin untuk menghapus data user ${e1["namavoucher"]} ?"),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(ctx);
                                                        },
                                                        child: Text("CANCEL")),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(ctx);
                                                          ApiSettingVoucher.delVoucher({
                                                            "idvoucherps": e1["idvoucherps"].toString(),
                                                          }).then((value) {
                                                            loadDataTable();
                                                          });
                                                        },
                                                        child: Text("OKAY")),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget halamanTambahEdit() {
    if (page == 1) {
      setState(() {
        kodeVoucherString = "tidak boleh kosong";
      });
    }
    if (page == 2 && initEditState == 0) {
      setState(() {
        namaVoucher.text = listDataTable[indexListDataTable]["namavoucher"];
        point.text = listDataTable[indexListDataTable]["point"].toString();
        kodeVoucher.text = listDataTable[indexListDataTable]["koderefeal"];
        keterangan.text = listDataTable[indexListDataTable]["keterangan"];
        menit.text = (listDataTable[indexListDataTable]["secondscounter"] / 60).toInt().toString();
        namaVoucherString = listDataTable[indexListDataTable]["namavoucher"];
        pointString = listDataTable[indexListDataTable]["point"].toString();
        kodeVoucherString = listDataTable[indexListDataTable]["koderefeal"];
        keteranganString = listDataTable[indexListDataTable]["keterangan"];
        menitString = (listDataTable[indexListDataTable]["secondscounter"] / 60).toInt().toString();
        stringListJenisPS = listDataTable[indexListDataTable]["jenisps"];
        initEditState = 1;
      });
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama Voucher", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: namaVoucher,
                  decoration: InputDecoration(
                    hintText: "Nama Voucher",
                  ),
                  onChanged: (_) {
                    setState(() {
                      namaVoucherString = _;
                    });
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text("Point", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: point,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Point",
                  ),
                  onChanged: (_) {
                    setState(() {
                      pointString = _;
                    });
                  },
                ),
              ],
            ),
            page == 1
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text("Kode Voucher", style: TextStyle(fontSize: 16)),
                      TextFormField(
                        controller: kodeVoucher,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Kode Voucher",
                        ),
                        onChanged: (_) {
                          setState(() {
                            pointString = _;
                          });
                        },
                      ),
                    ],
                  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text("Keterangan", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: keterangan,
                  decoration: InputDecoration(
                    hintText: "Keterangan",
                  ),
                  onChanged: (_) {
                    setState(() {
                      keteranganString = _;
                    });
                  },
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 16),
                Material(
                  elevation: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      dense: true,
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
                Row(
                  children: [
                    Text("Expired", style: TextStyle(fontSize: 16)),
                    Text(" * dalam jumlah hari", style: TextStyle(color: Colors.red)),
                  ],
                ),
                TextFormField(
                  controller: expired,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Expired",
                  ),
                  onChanged: (_) {
                    setState(() {
                      expiredString = _;
                    });
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text("Menit", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: menit,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Menit",
                  ),
                  onChanged: (_) {
                    setState(() {
                      menitString = _;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            FractionallySizedBox(
              widthFactor: 1,
              child: TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                onPressed: namaVoucherString == "" &&
                            pointString == "" &&
                            kodeVoucherString == "" &&
                            keteranganString == "" &&
                            expiredString == "" &&
                            menitString == "" &&
                            stringListJenisPS == "" ||
                        namaVoucherString == "" ||
                        pointString == "" ||
                        kodeVoucherString == "" ||
                        keteranganString == "" ||
                        expiredString == "" ||
                        menitString == "" ||
                        stringListJenisPS == ""
                    ? null
                    : () {
                        Map<String, dynamic> map = {
                          "idvoucherps": page == 1 ? "" : listDataTable[indexListDataTable]["idvoucherps"],
                          "namavoucher": namaVoucher.text,
                          "point": point.text,
                          "keterangan": keterangan.text,
                          "jenisps": stringListJenisPS,
                          "expired": expired.text,
                          "secondscounter": menit.text,
                        };
                        page == 1
                            ? ApiSettingVoucher.createVoucher(map).then((value) {
                                resetAllFormValue();
                                loadDataTable();
                              })
                            : ApiSettingVoucher.editVoucher(map).then((value) {
                                resetAllFormValue();
                                loadDataTable();
                              });
                      },
                icon: Icon(page == 1 ? Icons.add : Icons.edit),
                label: Text(page == 1 ? "TAMBAH VOUCHER" : "UPDATE VOUCHER"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
