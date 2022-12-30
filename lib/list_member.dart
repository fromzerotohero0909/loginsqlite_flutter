import 'package:flutter/material.dart';
import 'package:loginflutter/form_member.dart';
import 'package:loginflutter/database/database_instance.dart';
import 'package:loginflutter/model/member.dart';

class ListMemberPage extends StatefulWidget {
  const ListMemberPage({Key? key}) : super(key: key);

  @override
  _ListMemberPageState createState() => _ListMemberPageState();
}

class _ListMemberPageState extends State<ListMemberPage> {
  List<Member> listMember = [];
  DbMember db = DbMember();

  @override
  void initState() {
    //menjalankan fungsi getallMember saat pertama kali dimuat
    _getAllMember();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Data Member"),
        ),
      ),
      body: ListView.builder(
          itemCount: listMember.length,
          itemBuilder: (context, index) {
            Member member = listMember[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('${member.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("ID: ${member.id}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("address: ${member.address}"),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("tgl Lahir: ${member.date}"),
                    ),
                              Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Jenis Kelamin: ${member.gender}"),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("username: ${member.username}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("password: ${member.password}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(member);
                          },
                          icon: Icon(Icons.edit)),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${member.name}")
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteMember(member, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  //mengambil semua data Kontak
  Future<void> _getAllMember() async {
    //list menampung data dari database
    var list = await db.getAllMember();

    //ada perubahanan state
    setState(() {
      //hapus data pada listKontak
      listMember.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((member) {
        //masukan data ke listKontak
        listMember.add(Member.fromMap(member));
      });
    });
  }

  //menghapus data Member
  Future<void> _deleteMember(Member member, int position) async {
    await db.deleteMember(member.id!);
    setState(() {
      listMember.removeAt(position);
    });
  }

  // membuka halaman tambah Members
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormMember()));
    if (result == 'save') {
      await _getAllMember();
    }
  }

  //membuka halaman edit Kontak
  Future<void> _openFormEdit(Member member) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormMember(member: member)));
    if (result == 'update') {
      await _getAllMember();
    }
  }
}
