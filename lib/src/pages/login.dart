import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/src/pages/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
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
saveValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("email", "a@gmail.com");
}
//Buttom
Widget customButtom(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 2,
    height: 46,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Colors.green,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Home()),
              ModalRoute.withName("Home"));
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
                  "Log In",
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

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;
  User currentUser;
  @override
  void initState() {
    super.initState();
    initvalue();
  }
  void initvalue() async {
    prefs = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: EdgeInsets.only(top: 50, bottom: 5),
                child: socialLoginWidget(context),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15, top: 5),
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
                child: Center(
                  child: Text("Not Yet Register"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new SignUpPage()));
                  },
                  child: Center(
                    child: Text("Sign Up",),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    User firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;
    try{
      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          // Update data to server if new user
          FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .set({
            'nickname': firebaseUser.displayName,
            'photoUrl': firebaseUser.photoURL,
            'id': firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          });
          // Write data to local
          currentUser = firebaseUser;
          await prefs.setString('id', currentUser.uid);
          await prefs.setString('nickname', currentUser.displayName);
          await prefs.setString('photoUrl', currentUser.photoURL);
        } else {
          // Write data to local
          await prefs.setString('id', documents[0].data()['id']);
          await prefs.setString('nickname', documents[0].data()['nickname']);
          await prefs.setString('photoUrl', documents[0].data()['photoUrl']);
          await prefs.setString('aboutMe', documents[0].data()['aboutMe']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Home()),
              ModalRoute.withName("Home"));
        }
      } else {
        // Fluttertoast.showToast(msg: "Sign in fail");
      }
    }catch(error){
      print(error);
    }
  }
  //Logo
  Widget logoWidget(String path) {
    return Center(
      child: Image(
        height: 96,
        width: 96,
        image: AssetImage(path),
      ),
    );
  }
//Social Buttons
  Widget socialLoginWidget(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 45,
          width: ((MediaQuery.of(context).size.width) / 2),
          child: logoWidget("assets/fb.png"),
        ),
        SizedBox(
          height: 45,
          width: ((MediaQuery.of(context).size.width) / 5),
          child: GestureDetector(
            onTap: (){this.handleSignIn();},
            child: logoWidget("assets/g.png"),
          ),
        ),
      ],
    );
  }
}
