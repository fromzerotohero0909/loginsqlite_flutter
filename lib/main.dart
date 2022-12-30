import 'package:flutter/material.dart';
import 'package:loginflutter/list_member.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                    icon: Icon(Icons.person, size: 35),
                    labelText: 'Enter your username',
                    hintText: "Username"),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, size: 35),
                  labelText: 'Enter your password',
                  hintText: "Password",
                ),
                controller: password,
              ),
              Container(
                margin: EdgeInsets.all(
                  15.0,
                ),
                child: ElevatedButton(
                  // color: Colors.blueAccent,
                  onPressed: () {
                    if (username.text == "") {
                      setState(() {
                        Fluttertoast.showToast(
                            msg: "Username tidak boleh kosong",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER);
                      });
                    } else {
                      if (password.text == "") {
                        setState(() {
                          Fluttertoast.showToast(
                              msg: "Password tidak boleh kosong",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER);
                        });
                      } else {
                        if (username.text == "admin" &&
                            password.text == "admin") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListMemberPage()),
                          );
                        } else {
                          if (password.text.length < 6) {
                            setState(() {
                              Fluttertoast.showToast(
                                  msg: "Password Min 6 Karakter",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER);
                            });
                          } else {
                            setState(() {
                              Fluttertoast.showToast(
                                  msg: "Username atau Password Salah",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP);
                            });
                          }
                        }
                      }
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListMemberPage()),
          );
        },
        child: Text('lanjut'),
      ),
    );
  }
}
