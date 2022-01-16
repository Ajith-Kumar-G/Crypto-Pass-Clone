import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_pass/utils/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserInformation extends StatefulWidget {
  final Function(String) delete;
  String docId;
  bool deleteBool;
  UserInformation(this.delete, this.docId, this.deleteBool);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection("list/" + (AuthProvider().getUID()).toString() + "/pass_list")
      .snapshots();

  sendData(data, index) async {
    DocumentReference<Map<String, dynamic>> temp =
        FirebaseFirestore.instance.collection('temp').doc(widget.docId);
    await temp.set({
      'Pass': data.docs[index]['Password'],
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sent password')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occured during sending of data")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.77,
      child: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          final data = snapshot.requireData;

          return Container(
            // height: MediaQuery.of(context).size.height * 0.77,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (widget.deleteBool) {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                    'Please confirm deletion by pressing ok.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      widget.delete(
                                          data.docs[index].id.toString());
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text(data.docs[index]['Name']),
                                ),
                                IconButton(
                                  color: Colors.blue,
                                  tooltip: 'Send Website Sign in details',
                                  splashColor: Colors.green,
                                  onPressed: () {
                                    if (widget.docId != "")
                                      sendData(data, index);
                                    else
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Scan a QR')),
                                      );
                                  },
                                  icon: Icon(Icons.send),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          );

          //  ListView(
          //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //     Map<String, dynamic> data =
          //         document.data()! as Map<String, dynamic>;
          //     return ListTile(
          //       title: Text(data['Name']),
          //       subtitle: Text(data['Password']),
          //     );
          //   }).toList(),
          // );
        },
      ),
    );
  }
}
