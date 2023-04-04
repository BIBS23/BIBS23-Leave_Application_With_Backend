import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sjcet_leave/provider/detailsControllers.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Admin Panel',
                style: TextStyle(fontSize: 16, letterSpacing: 6)),
            centerTitle: true),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('details').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                 if (!streamSnapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              return Consumer<DetailsController>(
                  builder: (context, details, child) {
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      final String documentId = documentSnapshot.id;
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    spreadRadius: 2)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Name: ${documentSnapshot['name']}'),
                                Text(
                                    'Branch: ${documentSnapshot['branch']}'),
                                Text(
                                    'RollNo: ${documentSnapshot['rollno']}'),
                                Text(
                                    'Reason: \n${documentSnapshot['reason']}'),
                                Text(
                                    'Leave Type: ${documentSnapshot['leavetype']}'),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        TextButton(
                              onPressed: () {
                                setState(() {
                                  details.acceptOrReject(documentId,true);
                                });
                              },
                              child: const Text('Accept')),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  details.acceptOrReject(documentId,false);
                                });
                              },
                              child: Text('Reject')),
                                      ],
                                    )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              });
            }));
  }
}
