import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_loca_game/ui/5.%20Pengaturan/api/4.api_daftar_operator.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class DialogDaftarOperator extends StatefulWidget {
  const DialogDaftarOperator({Key? key}) : super(key: key);

  @override
  _DialogDaftarOperatorState createState() => _DialogDaftarOperatorState();
}

class _DialogDaftarOperatorState extends State<DialogDaftarOperator> {
  late LinkedScrollControllerGroup tablelinkedScrollController = LinkedScrollControllerGroup();
  ScrollController tableScrollController1 = ScrollController();
  ScrollController tableScrollController2 = ScrollController();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String usernameString = "";
  String passwordString = "";
  bool passwordVisibility = false;

  List listDataTable = [];
  int indexListDataTable = -1;

  Future<void> loadDataTable() async {
    print("loadDataTable...");
    setState(() {
      listDataTable = [];
    });
    await ApiDaftarOperator.ngeListUsers().then((value) {
      setState(() {
        listDataTable = jsonDecode(value.body);
      });
    });
  }

  late StateSetter roleStateSetter;
  List<String> listRole = ["admin", "operator"];
  List<String> roleSelected = [];

  void roleStateAction(List<String> role) {
    setState(() {
      roleSelected = role;
    });
  }

  void dialogSelectRole(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          List<String> selectedRole = roleSelected;
          return StatefulBuilder(builder: (BuildContext __, StateSetter setter) {
            roleStateSetter = setter;
            return AlertDialog(
              title: Text("Pilih Role"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: listRole.map((e) {
                  return CheckboxListTile(
                    value: selectedRole.contains(e) ? true : false,
                    onChanged: (_) {
                      if (_ == false) {
                        roleStateSetter(() {
                          selectedRole.remove(e);
                        });
                      } else {
                        roleStateSetter(() {
                          selectedRole.add(e);
                        });
                      }
                      print(selectedRole);
                    },
                    title: Text(e),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  );
                }).toList(),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(_);
                      },
                      child: Text("CANCEL"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(_);
                        roleStateAction(selectedRole);
                      },
                      child: Text("OKAY"),
                    ),
                  ],
                )
              ],
            );
          });
        });
  }

  void resetAllFormValue() {
    setState(() {
      dialogPage = 0;
      username.text = "";
      password.text = "";
      passwordVisibility = false;
      roleSelected = [];
    });
  }

  int dialogPage = 0;
  int initEditState = 0;

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
    bool isButtonActive() {
      return usernameString == "" && passwordString == "" && roleSelected.isEmpty || usernameString == "" || passwordString == "" || roleSelected.isEmpty
          ? false
          : true;
    }

    return AlertDialog(
      title: dialogPage == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Daftar Operator"),
                TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                  onPressed: () {
                    setState(() {
                      dialogPage = 1;
                    });
                  },
                  icon: Icon(Icons.add),
                  label: Text("TAMBAH"),
                ),
              ],
            )
          : Row(
              children: [
                IconButton(
                    onPressed: () {
                      resetAllFormValue();
                    },
                    icon: Icon(Icons.arrow_back)),
                SizedBox(width: 8),
                Text(dialogPage == 1 ? "Tambah Operator" : "Edit Operator"),
              ],
            ),
      insetPadding: EdgeInsets.all(24),
      contentPadding: EdgeInsets.all(12),
      content: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(minHeight: 200, maxHeight: 360),
        child: dialogPage == 0 ? halamanAwal() : halamanTambahEdit(),
      ),
      actions: dialogPage == 0
          ? null
          : [
              FractionallySizedBox(
                widthFactor: 1,
                child: TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                  onPressed: isButtonActive()
                      ? () {
                          Map<String, dynamic> map = {
                            "iduser": dialogPage == 1 ? "" : listDataTable[indexListDataTable]["iduser"],
                            "username": username.text,
                            "password": password.text,
                            "role": roleSelected.join(",")
                          };
                          if (dialogPage == 1) {
                            ApiDaftarOperator.ngeAddUser(map).then((value) {
                              resetAllFormValue();
                              loadDataTable();
                            });
                          } else {
                            ApiDaftarOperator.ngeditUser(map).then((value) {
                              resetAllFormValue();
                              loadDataTable();
                            });
                          }
                        }
                      : null,
                  icon: Icon(dialogPage == 1 ? Icons.add : Icons.edit),
                  label: Text(dialogPage == 1 ? "TAMBAH OPERATOR" : "EDIT OPERATOR"),
                ),
              ),
            ],
    );
  }

  Widget halamanAwal() {
    double lebar = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          color: Colors.blue,
          height: 60,
          child: Row(
            children: [
              Material(
                  elevation: 4,
                  color: Colors.blue,
                  child: Container(width: lebar * 0.125, child: Center(child: Text("No.", style: TextStyle(color: Colors.white))))),
              Expanded(
                  child: SingleChildScrollView(
                controller: tableScrollController1,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: lebar * 0.275, child: Text("Username", style: TextStyle(color: Colors.white))),
                    Container(width: lebar * 0.275, child: Text("Posisi", style: TextStyle(color: Colors.white))),
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
                      elevation: 4,
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
                              Container(width: lebar * 0.275, child: Text(e1["username"])),
                              Container(width: lebar * 0.275, child: Text(e1["role"])),
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
                                            dialogPage = 2;
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
                                              content: Text("Apakah anda yakin untuk menghapus data user ${e1["username"]} ?"),
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
                                                          ApiDaftarOperator.ngeDelUser({
                                                            "iduser": listDataTable[indexListDataTable]["iduser"],
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget halamanTambahEdit() {
    if (dialogPage == 2 && initEditState == 0) {
      setState(() {
        username = TextEditingController(text: listDataTable[indexListDataTable]["username"]);
        password = TextEditingController(text: listDataTable[indexListDataTable]["password"]);
        usernameString = listDataTable[indexListDataTable]["username"];
        passwordString = listDataTable[indexListDataTable]["password"];
        roleSelected = listDataTable[indexListDataTable]["role"].split(",");
        initEditState = 1;
      });
    }
    return SingleChildScrollView(
      child: Container(
        color: Colors.white10,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text("Username", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(hintText: "Username"),
                  onChanged: (_) {
                    setState(() {
                      usernameString = _;
                    });
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text("Password", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: password,
                  obscureText: !passwordVisibility,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (passwordVisibility == false) {
                            passwordVisibility = true;
                          } else {
                            passwordVisibility = false;
                          }
                        });
                      },
                      icon: Icon(!passwordVisibility ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  onChanged: (_) {
                    setState(() {
                      passwordString = _;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Material(
              color: Colors.transparent,
              child: ListTile(
                tileColor: Colors.white10,
                title: Text("Role"),
                leading: Icon(Icons.sort),
                trailing: Text(roleSelected.isEmpty ? "Pilih role" : roleSelected.join(",")),
                onTap: () {
                  dialogSelectRole(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
