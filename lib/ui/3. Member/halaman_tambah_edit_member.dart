import 'package:flutter/material.dart';

class HalamanTambahEditMember extends StatefulWidget {
  const HalamanTambahEditMember({Key? key, required this.addOrEdit}) : super(key: key);
  final String addOrEdit;

  @override
  _HalamanTambahEditMemberState createState() => _HalamanTambahEditMemberState();
}

class _HalamanTambahEditMemberState extends State<HalamanTambahEditMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.addOrEdit == "add" ? "Tambah Member" : "Edit Member"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.black38),
              onPressed: () {},
              icon: Icon(widget.addOrEdit == "add" ? Icons.add : Icons.edit),
              label: Text(widget.addOrEdit == "add" ? "TAMBAH" : "PERBARUI"),
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
