import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sjcet_leave/provider/signoutController.dart';
import 'package:sjcet_leave/screens/modal_screen.dart';
import 'package:sjcet_leave/provider/detailsControllers.dart';
import 'package:sjcet_leave/utils/leave_tile.dart';
import 'package:sjcet_leave/utils/mybtn.dart';

import 'admin_page.dart';

class Home extends StatefulWidget {
  Home({super.key});
  bool update = false;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Leave Hive',
              style: TextStyle(fontSize: 16, letterSpacing: 6)),
              automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: const Text('Are you sure you want to leave ?'),
                        content: Consumer<SignOutController>(
                            builder: (context, signout, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    signout.signout();
                                  }),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'))
                            ],
                          );
                        }),
                      );
                    }));
              },
              icon: const Icon(Icons.logout_outlined),
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('details')
                .where('user',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (!streamSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return Consumer<DetailsController>(
                  builder: (context, details, child) {
                return Stack(children: [
                  Container(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LeaveTile(
                              leaveImg: 'assets/medical.jpg',
                              leaveTitle: 'Medical Leave',
                              onTap: () async {
                                await ApplyLeave.modalScreen(context, true);
                                details.leaveType('Medical Leave');
                              },
                            ),
                            LeaveTile(
                              leaveImg: 'assets/duty.png',
                              leaveTitle: 'Duty Leave',
                              onTap: () async {
                                await ApplyLeave.modalScreen(context, true);
                                details.leaveType('Duty Leave');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LeaveTile(
                              leaveImg: 'assets/periods.png',
                              leaveTitle: 'Menstrual Leave',
                              onTap: () async {
                                await ApplyLeave.modalScreen(context, false);
                                details.leaveType('Menstrual Leave');
                              },
                            ),
                            LeaveTile(
                              leaveImg: 'assets/personal.png',
                              leaveTitle: 'Personal Leave',
                              onTap: () async {
                                await ApplyLeave.modalScreen(context, false);
                                details.leaveType('Personal Leave');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 300,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.95,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminPage()));
                              },
                              child: const Text('Admin page')),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];
                                    final documentId = documentSnapshot.id;

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15, right: 15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 7,
                                                  spreadRadius: 2)
                                            ]),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 10),
                                                Text(
                                                    'name : ${documentSnapshot['name']}'),
                                                const SizedBox(height: 10),
                                                Text(
                                                    'Branch : ${documentSnapshot['branch']}'),
                                                const SizedBox(height: 10),
                                                Text(
                                                    'Rollno : ${documentSnapshot['rollno']}'),
                                                const SizedBox(height: 10),
                                                Text(
                                                    'Leave Type : ${documentSnapshot['leavetype']}'),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                            Container(
                                              height: 18,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color: documentSnapshot[
                                                              'status'] ==
                                                          null
                                                      ? Colors.white
                                                      : documentSnapshot[
                                                              'status']
                                                          ? Colors.green
                                                          : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: Center(
                                                  child: Text(
                                                    documentSnapshot[
                                                                'status'] ==
                                                            null
                                                        ? 'pending'
                                                        : documentSnapshot[
                                                                'status']
                                                            ? 'Accepted'
                                                            : 'Rejected',
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                        ],
                      ),
                    ),
                  ),
                ]);
              });
            }));
  }
}
