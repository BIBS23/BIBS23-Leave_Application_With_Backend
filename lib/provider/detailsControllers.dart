import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DetailsController extends ChangeNotifier {
   String? docId;
 
  CollectionReference collectionRef =
  FirebaseFirestore.instance.collection('details');

  void getDetails(
      String name, String branch, String rollno, String reason, String status) async{
    DocumentReference docRef= await collectionRef.add({
      'name': name,
      'branch': branch,
      'rollno': rollno,
      'reason': reason,
      'status': null,
      'leavetype': null
    });
     docId = docRef.id;

    notifyListeners();
  }

  void acceptOrReject(String id, bool? status) {
    collectionRef.doc(id).update({'status': status});

    notifyListeners();
  }

  void leaveType(String leavetype) {
    if (docId != null) { 
      collectionRef.doc(docId).update({'leavetype': leavetype});
    }
  }
}
