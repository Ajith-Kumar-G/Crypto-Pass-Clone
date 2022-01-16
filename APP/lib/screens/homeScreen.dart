import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_pass/modals/list.dart';
import 'package:crypto_pass/utils/firebase_auth.dart';
import 'package:crypto_pass/utils/instance_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../modals/add_modal.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void addSite(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (ctx) {
        return GestureDetector(
          child: Container(
            child: AddSite(),
            //padding: MediaQuery.of(context).viewInsets,
          ),
        );
      },
    );
  }

  void pushUser() {}
  Widget nullCheck(name) {
    if (name != null)
      return Text(name);
    else
      return Text('Anonymous');
  }

  bool deleteBool = false;
  delete(String docId) {
    {
      if (deleteBool)
        FirebaseFirestore.instance
            .collection(
                "list/" + (AuthProvider().getUID()).toString() + "/pass_list")
            .doc(docId)
            .delete();
    }
  }

  late String qrCode = "";
  Future<void> scanQR() async {
    try {
      var qrcode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print('data');
      print(qrcode);
      if (!mounted) return;
      setState(() {
        qrCode = qrcode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform';
      print('data');
    }
  }

  bool check() {
    bool veirfy = Instance().verifiedEmail();
    // ignore: unnecessary_null_comparison
    if (veirfy != null && veirfy) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: nullCheck(AuthProvider().getMail()),
          backgroundColor: Color(0xFF090070),
          leading: Image.asset('assets/icons/icon.png'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF530070),
              ),
              onPressed: () {
                AuthProvider().logOut();
              },
              child: Text('Log Out'),
            ),
          ]),
      body: Container(
        // padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.5, -3.06),
            end: Alignment(0.5, 1),
            colors: <Color>[
              Color(0xFF090070),
              Color(0xFF530070),
            ],
          ),
        ),
        child: check()
            ? SizedBox(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    UserInformation(delete, qrCode, deleteBool),
                    Container(
                      decoration: BoxDecoration(color: Color(0xFF090070)),
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Center(
                            heightFactor: 1.2727,
                            child: IconButton(
                              icon: Icon(
                                Icons.remove_circle,
                                color: deleteBool ? Colors.red : Colors.white,
                                size: 44,
                              ),
                              onPressed: () {
                                setState(() {
                                  deleteBool = !deleteBool;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.qr_code_scanner,
                              size: 56,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              scanQR();
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              size: 44,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //startTime();
                              addSite(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    height: MediaQuery.of(context).size.width * 0.4,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      children: [
                        Text(
                          "Email unverified ",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Please Logout and verify your email id'),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
