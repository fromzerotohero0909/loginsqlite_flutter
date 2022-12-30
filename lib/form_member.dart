import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loginflutter/database/database_instance.dart';
import 'package:loginflutter/model/member.dart';

class FormMember extends StatefulWidget {
  final Member? member;

  FormMember({this.member});

  @override
  _FormMemberState createState() => _FormMemberState();
}

class _FormMemberState extends State<FormMember> {
  DbMember db = DbMember();

  TextEditingController? name;
  TextEditingController? address;
  TextEditingController? date;
  TextEditingController? username;
  TextEditingController? password;
  String? gender;
  @override
  void pilihGender(String? value) {
    setState(() {
      gender = value;
    });
  }

  void initState() {
    name = TextEditingController(
        text: widget.member == null ? '' : widget.member!.name);

    address = TextEditingController(
        text: widget.member == null ? '' : widget.member!.address);

    date = TextEditingController(
        text: widget.member == null ? '' : widget.member!.date);


    username = TextEditingController(
        text: widget.member == null ? '' : widget.member!.username);

    password = TextEditingController(
        text: widget.member == null ? '' : widget.member!.password);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Member'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  icon: Icon(Icons.card_membership, size: 35),
                  labelText: "Name",
                  hintText: "Enter your Name"),
              keyboardType: TextInputType.text,
            ),
          ),
          TextFormField(
            controller: date,
            decoration: InputDecoration(
                icon: Icon(Icons.date_range, size: 35),
                labelText: "Date Of Birth",
                hintText: "insert your dob"),
            onTap: () async {
              //DateTime selectedDate = DateTime.now();
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                date?.text = selectedDate.toString().split(' ')[0];
              }
              //
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter date';
              }
            },
            onChanged: (val) => print(val),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: address,
            decoration: InputDecoration(
                icon: Icon(Icons.home, size: 35),
                labelText: "Enter your address",
                hintText: "Addresss"),
            keyboardType: TextInputType.streetAddress,
          ),
          DropdownButtonFormField<String>(
            value: gender,
            decoration: InputDecoration(
                icon: Icon(Icons.perm_identity, size: 35),
                labelText: "Jenis Kelamain",
                hintText: "Jenis Kelamin"),
            style: const TextStyle(color: Colors.deepPurple),

            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                gender = value!;
              });
            },
            items: ["Laki-laki","perempuan"].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextFormField(
            controller: username,
            decoration: InputDecoration(
                icon: Icon(Icons.person, size: 35),
                labelText: "username",
                hintText: "Enter your username"),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: password,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock, size: 35),
                labelText: "Password",
                hintText: "Enter your Password"),
            //controller:pass,
          ),
          /*
          Container(
              child: Row(
            children: [
              Flexible(
                child: RadioListTile(
                  value: "Laki Laki",
                  groupValue: gender,
                  onChanged: (String? value) {
                    setState(
                      () {
                        pilihGender(value);
                      },
                    );
                  },
                  title: Text("Laki Laki"),
                  activeColor: Colors.green,
                ),
              ),
              Flexible(
                child: RadioListTile(
                  value: "Perempuan",
                  groupValue: gender,
                  onChanged: (String? value) {
                    setState(
                      () {
                        pilihGender(value);
                      },
                    );
                  },
                  title: Text("Perempuan"),
                  activeColor: Colors.blueAccent,
                ),
              ),
            ],
          )),

        */
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              margin: EdgeInsets.all(
                15.0,
              ),
              child: ElevatedButton(
                child: (widget.member == null)
                    ? Text(
                        'Add',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    : Text(
                        'Update',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                onPressed: () {
                  upsertMember();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertMember() async {
    if (widget.member != null) {
      //update
      await db.updateMember(Member(
        id: widget.member?.id,
        name: name!.text,
        gender: gender,
        address: address!.text,
        date: date!.text,
        username: username!.text,
        password: password!.text,

      ));

      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveMember(Member(
        name: name!.text,
        address: address!.text,
        date: date!.text,
        username: username!.text,
        password: password!.text,
        gender: gender,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
