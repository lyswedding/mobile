import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return signupwidget();
  }

  Widget signupwidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
          height: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
              color: new Color(0xffF5591F)),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Container(height: 150, child: Image.asset("images/icon.png")),
                Container(
                  padding: EdgeInsets.only(right: 30),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                )
              ]))),
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: TextField(
          cursorColor: Color(0xffF5591F),
          decoration: InputDecoration(
            icon: Icon(
              Icons.person,
              color: Color(0xffF5591F),
            ),
            hintText: "Enter user name",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: TextField(
          cursorColor: Color(0xffF5591F),
          decoration: InputDecoration(
            icon: Icon(
              Icons.email,
              color: Color(0xffF5591F),
            ),
            hintText: "Enter Email",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: TextField(
          cursorColor: Color(0xffF5591F),
          decoration: InputDecoration(
            icon: Icon(
              Icons.password,
              color: Color(0xffF5591F),
            ),
            hintText: "Enter Password",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: TextField(
          cursorColor: Color(0xffF5591F),
          decoration: InputDecoration(
            icon: Icon(
              Icons.password,
              color: Color(0xffF5591F),
            ),
            hintText: "Confirm Password",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          // Write Click Listener Code Here.
        },
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20, right: 20, top: 30),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 54,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [(new Color(0xffF5591F)), new Color(0xffF2861E)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xffEEEEEE)),
              ],
            ),
            child: FlatButton(
              child: Text(
                "REGISTER",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login(),
                    ));
              },
            )),
      ),
      Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("I Have Already "),
          GestureDetector(
            child: Text(
              "Account",
              style: TextStyle(color: Color(0xffF5591F)),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ));
            },
          )
        ]),
      ),
    ])));
  }
}
