import 'package:crypto_pass/utils/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class AddSite extends StatelessWidget {
  AddSite({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: 40,
              top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add the Details :",
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Color(0xFFBFBFBF),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFBFBFBF),
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFFBFBFBF),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFBFBFBF),
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    CollectionReference users = FirebaseFirestore.instance
                        .collection('list')
                        .doc(AuthProvider().getUID())
                        .collection('pass_list');
                    await users
                        .add({
                          'Name': nameController.text,
                          'Password': passwordController.text,
                        })
                        .then((value) => print("Site added"))
                        .catchError(
                            (error) => print("Failed to add site: $error"));
                  },
                  child: Text('Done')),
            ],
          ),
        ),
      ),
    );
  }
}
