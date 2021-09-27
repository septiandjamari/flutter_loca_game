import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class HalamanUtamaLaporan extends StatefulWidget {
  const HalamanUtamaLaporan({Key? key}) : super(key: key);

  @override
  _HalamanUtamaLaporanState createState() => _HalamanUtamaLaporanState();
}

class _HalamanUtamaLaporanState extends State<HalamanUtamaLaporan> {
  bool sortingContainerIsActive = false;
  DateTime tanggalMulai = DateTime.now();
  DateTime tanggalSampai = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          sortingContainerIsActive == true
              ? sortingContainer()
              : FractionallySizedBox(
                  widthFactor: 1,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        sortingContainerIsActive = true;
                      });
                    },
                    icon: Icon(Icons.sort),
                    label: Text("TAMPILKAN PENGURUTAN"),
                  ),
                ),
        ],
      ),
    );
  }

  Widget sortingContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.16,
                child: ListTile(
                  leading: Icon(Icons.person),
                  dense: true,
                ),
              ),
              Material(
                elevation: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ListTile(
                    onTap: () {},
                    title: Text("Berdasar user", style: TextStyle(fontSize: 14)),
                    subtitle: Text("LOCAGAMECODO", style: TextStyle(fontSize: 12)),
                    dense: true,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.16,
                child: ListTile(
                  leading: Icon(Icons.calendar_today),
                  dense: true,
                ),
              ),
              Row(
                children: [
                  Material(
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(2021, 9, 26).subtract(Duration(days: 30)),
                            maxTime: DateTime.now(),
                            onConfirm: (date) {
                              setState(() {
                                tanggalMulai = date;
                              });
                            },
                            currentTime: tanggalMulai,
                            locale: LocaleType.id,
                          );
                        },
                        title: Text("Tanggal Mulai", style: TextStyle(fontSize: 14)),
                        subtitle: Text("${DateFormat.yMd("id_ID").format(tanggalMulai)}", style: TextStyle(fontSize: 12)),
                        dense: true,
                      ),
                    ),
                  ),
                  Material(
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(2021, 9, 26).subtract(Duration(days: 30)),
                            maxTime: DateTime.now(),
                            onConfirm: (date) {
                              setState(() {
                                tanggalSampai = date;
                              });
                            },
                            currentTime: tanggalSampai,
                            locale: LocaleType.id,
                          );
                        },
                        title: Text("Sampai Tanggal", style: TextStyle(fontSize: 14)),
                        subtitle: Text("${DateFormat.yMd("id_ID").format(tanggalSampai)}", style: TextStyle(fontSize: 12)),
                        dense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              setState(() {
                sortingContainerIsActive = false;
              });
            },
            child: Text("SEMBUNYIKAN"),
          )
        ],
      ),
    );
  }
}
