import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
saveValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("email", "a@gmail.com");
}
//TextInput
Widget TextInput(hintData, labelData, type) {
  return SizedBox(
      height: 45,
      width: double.infinity,
      child: TextField(
        decoration: InputDecoration(
            hintText: hintData,
            labelText: labelData,
            labelStyle: TextStyle(fontSize: 15, color: Colors.black),
            hintStyle: TextStyle(fontSize: 11, color: Colors.black38),
            contentPadding: EdgeInsets.all(5),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12)),
            focusColor: Colors.black12,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12))),
        keyboardType: type == "email"
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        obscureText: type == "email" ? false : true,
      ));
}
//Buttom
Widget customButtom(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width/2,
    height: 46,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Colors.green,
      child: GestureDetector(
        onTap: (){

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Home()),ModalRoute.withName("Home"));
          saveValue();
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 21,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
//Logo
Widget logoWidget(String path) {
  return Center(
    child:Image(
      height: 96,
      width: 96,
      image: AssetImage(path),
    ),
  );
}
//Social Buttons
Widget socialLoginWidget(BuildContext context){
  return Row(
    children: [
      SizedBox(
        height: 45,
        width: ((MediaQuery.of(context).size.width)/2),
        child: logoWidget("assets/fb.png"),
      ),
      SizedBox(
        height: 45,
        width: ((MediaQuery.of(context).size.width)/5),
        child: logoWidget("assets/g.png"),
      ),
    ],
  );
}
class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation:0
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              logoWidget("assets/General/app.png"),
              Padding(
                padding: EdgeInsets.only(top: 0,bottom: 5),
                child: socialLoginWidget(context),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15,top: 5),
                child: Text("Get in using social account ."),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: TextInput("Email *", "Email *", "email"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextInput("Password *", "Password *", "password"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: customButtom(context),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child:Center(
                  child: Text("Already Register"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child:GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Text("Log In"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
